Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB062DCBE3;
	Sat, 21 Mar 2026 00:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774054591; cv=none; b=r/rkyXih61kDWrWO+BcpR3XAh5lalh7vNt34o6zHI5GG3OisIyPbwP7lnhir6tcgCsOsiT8eTpAbp/2X1zCA9MkEENTLBJDNZCn6A/5FNWXta23QMJqBrW7thSq74ZBOTcZGjoUgjvPDd4Nysu9CcfLyGF/HHxnc6Vwae5+0ybw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774054591; c=relaxed/simple;
	bh=X5LAPF88+rblE8Ugn+wC0BXFx9Vjd5ZwEootGLaNZDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxkqdX1si7y4AY5QGurmaYaRc0vkMU0om7lt+zrHGO31+B+LabFUbNA6AM0PSxPXQq9oPafk87OXbigahuY8D/tGS5CREcnl7kcpHz7ona1TYeaIYwXkfnkGxKLP9zxPxyZYPg+bnbDBWOZsY7E3CHXTGFudLn16wHus/c+oSRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/WQDoj+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/WQDoj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39195C4CEF7;
	Sat, 21 Mar 2026 00:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774054591;
	bh=X5LAPF88+rblE8Ugn+wC0BXFx9Vjd5ZwEootGLaNZDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t/WQDoj+g2goXyVhP60iGs5t0CgWyN7V18mpDPFP6D5P2HlOh8dkKjK1BEzDFiVJ/
	 75NDU9mFh/kOZWiAqvcTTZAQmwT88dvsTmLhl+9vNhUH5PCacQEztEMfCHqUakGkN/
	 Bmbgp04vjr/yxrQjf1FsuEmJqSn0AmEFLsQKXr80QmIvTxhRsCOIsA26tzVLNy6hAE
	 OJZjVx8sK6/0nFvDzjdGnOrs1BCVrXHyWdM4jdOyTmtarK3tzrKG7FariCB6PYB0Fc
	 6g3GASyo1Gvl7aBeZYajLcYE2RTqG+I7bhdZejqGa/fBXX6y/e5UQQcTR2+7KtoZw3
	 ustmc459kTnyg==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm/damon/sysfs: check contexts->nr before accessing contexts_arr[0]
Date: Fri, 20 Mar 2026 17:56:20 -0700
Message-ID: <20260321005622.81193-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320163559.178101-2-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


On Fri, 20 Mar 2026 16:35:58 +0000 Josh Law <objecting@objecting.org> wrote:

> Multiple sysfs command paths dereference contexts_arr[0] without first
> verifying that nr_contexts >= 1.

Nit.  There is no 'nr_contexts' in the code.  Let's use kdamond->contexts->nr
or contexts->nr instead.

> A user can set nr_contexts to 0 via
> sysfs while DAMON is running, causing NULL pointer dereferences.

It would be nice to explain how users can reproducer the issue.  Could you
please add below to this part of the commit message?

'''
The issue can be triggered by privileged users like below.

First, start DAMON and make contexts directory empty (kdamond->contexts->nr ==
0).

    # damo start
    # cd /sys/kernel/mm/damon/admin/kdamonds/0
    # echo 0 > contexts/nr_contexts

Then, any of below commands will cause the NULL pointer dereference.

    # echo update_schemes_stats > state
    # echo update_schemes_tried_regions > state
    # echo update_schemes_tried_bytes > state
    # echo update_schemes_effective_quotas > state
    # echo update_tuned_intervals > state
'''

>
> Guard all commands (except OFF) at the entry point of
> damon_sysfs_handle_cmd().
>
> Fixes: 0ac32b8affb5 ("mm/damon/sysfs: support DAMOS stats")
> Cc: <stable@vger.kernel.org>  # 5.18.x
> Signed-off-by: Josh Law <objecting@objecting.org>
> Reviewed-by: SeongJae Park <sj@kernel.org>

I suggested [1] this patch.  But I didn't give you 'Revied-by:' tag.  So the
above Reviewed-by: is not valid.

And this patch looks good to me, so please take my valid Reviewed-by: tag.

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---

From the next time, please add patch version changelog [2] here.

I added this patch into my tree after resolving the trivial things I mentioned
above.  I will post it as v3 tomorrow, unless Andrew add this to mm.git after
resolving the trivial things as I mentioned.

[1] https://lore.kernel.org/20260320155115.101025-1-sj@kernel.org
[2] https://docs.kernel.org/process/submitting-patches.html#commentary


Thanks,
SJ

[...]
