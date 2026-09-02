Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB334A0151;
	Wed,  2 Sep 2026 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359834; cv=none; b=PxDf4URrqP3hAlnFrBNA6R4Le0D0IT9F4QjMFEUI+RJ6BISLSbsDlS0+uZPlhIcMP+tRjIoWSiw7K9wtpXn7PlrTiYHmvPDLRboxtCwwwtEk4QeeKAL0DjCiezliUCm4QRgzGw1Ddo/UN4ofzMYdoVSn/L147ql75uQCb9svV6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359834; c=relaxed/simple;
	bh=R1LTX4GzOO/C0/yyEfvuZo+Cm0Mrw8PKeSruta2Sfck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRB3HS9uBGvCe02E6B8tQ80YIKLi3Ph9hsPIBy1v28MmZnvzHiBBRZDjTlJ0bfZinkF/2DnA21xT+p8Wct2G8kf3qaZVbCE9ZWCGikxSxI+M/JV1iSHQlJRnZwPieobupt1kWb9Fkgu1jHtBkgrr6ycDhGLzCBL/9A3HRELe/w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcX7IbD1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcX7IbD1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DC21F000E9;
	Wed,  2 Sep 2026 14:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788359833;
	bh=uJ8oZbnT/S4xxSU2BGbADIIkq11+Ga6+O5vtB95nhK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gcX7IbD1yaF6KhJx1sjAKj+kDIfGPBq8StoP/xFceP1LI0AXebsGAYHR3rS8EMCQl
	 O7H9AQUHoilFNp6tkm2Vj0qTcvjTQcqiRZ9QnEU4+OvqSbShgm8fzZypPCg0EbhOB0
	 a/W9WbU1Vaf8Qx+Kon+bROdWBDiNZwX5q4FbwG4JEFFW0mCgsZrvle/x87XLIgdMen
	 Qo0G1Ns1TNxrnKw33LpbJLHD6C1zjHLB6JTEbr8IfWuQtuLImT/y/8QIjwc7eTfaDS
	 l5OU8ziIk2jRyz9DZgoge4GL7gSbofQG7yVFBQOa/lnZENIfJr399XgAp+TDk8kY86
	 hG3DBfzCYle1g==
From: SJ Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 05/12] mm/damon/sysfs: remove probes number validation
Date: Wed,  2 Sep 2026 07:37:06 -0700
Message-ID: <20260902143706.88115-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902140714.4023700-1-kunwu.chan@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Sep 2026 22:07:13 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrote:

> On Tue,  1 Sep 2026 22:47:38 -0700 SJ Park <sj@kernel.org> wrote:
[...]
> I was wondering whether DAMON_MAX_PROBES is purely a core invariant
> or also an interface constraint.

Thank you for reviewing my patch and raising this question!

> 
> With this change, sysfs allows nr_probes larger than
> DAMON_MAX_PROBES and damon_sysfs_probes_add_dirs() will start creating
> probe objects before the configuration is later rejected by
> damon_valid_probe_params().
> 
> Since nr_probes directly controls the number of sysfs objects created,
> do we still want to keep an early check here?
> 
> I agree that the core validation is required for non-sysfs callers,
> but I am not sure whether this particular limit should be duplicated
> at the sysfs layer.

I agree the user experience may be not that good.

In my humble opinion, however, keeping code simplicity is more important than
the user experience here.  After all, DAMON_SYSFS is recommended to be used by
another high level tools like DAMON user-space tool (damo) rather than human
fingers.  The user-space tools like damo can do the early check.

Please feel free to let me know if you have any other opinions or questions.


Thanks,
SJ

[...]
