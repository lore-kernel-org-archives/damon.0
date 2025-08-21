Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52AA2DE6F8;
	Thu, 21 Aug 2025 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795553; cv=none; b=rsk5i5hcxbeOER1Q+zX7fPCAKQRKTNEy9eTtoIkAOwbdBy79N+RVzEv8VHSObvtZOhuyEI+Mll+SFpQ5eHvxX8TmRGtpObfUUfsNAyGHldXDqL4ViP/EA3TUZX6fVoUAOdQRyuw+z2PS8r4LMDsxxYokx0Ve8DcLaei540Yk1nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795553; c=relaxed/simple;
	bh=lluNge2cWGquXLKIKjAjPmT4YYpm8dK1DV0H182H8zE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pD8W04CFrUl/9kCOi0epWyCcFw0oceMb7xUWdHFGlVbbr5WMhU3S9zHQoncf4Unu9UMqjoNrJkKYkNqxjaP5WYFPwPk363pQERgnCS2WV+nps8SY5VghpTqks/RR/OjUy+3jJOCTm8Xy1ClhjRvg8JFYujEsLefAQBYD0sJ4wac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlj+MY03; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlj+MY03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278FBC4CEEB;
	Thu, 21 Aug 2025 16:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755795553;
	bh=lluNge2cWGquXLKIKjAjPmT4YYpm8dK1DV0H182H8zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nlj+MY03Ri0+qCpt6vlRjDsttq+/Tpvtz0u7ivy1P1So/s98IONLh5iE18yM/xUnn
	 zVGoSQ1Th6Apgif30FDi42/4ue2M/7HZwJBB7yGFnlBLi4ct6gxRyhCnJB7Q2dvnnR
	 lscIiFco7yEwKKRbM636Zs4vXI+y9EyDnFwO3WVKrMsrO0VB2pdpVh8TPO5OyUa9rI
	 UuyMk1jiP1syw0EIma0xOUy7atHBezZ1lH2R3/5CBZ6pfvWm79OMYFeFFAvT2qhb0p
	 OrWrLsUxZ5ovod1iYxqeY8VdQZoe43RNSWO3lucjmmzvWaxq8H8hhlnwRl7LYhX2td
	 eno4p/QFg7o+Q==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com,
	apanyaki@amazon.com
Subject: Re: [PATCH] mm/damon/core: prevent unnecessary overflow in damos_set_effective_quota()
Date: Thu, 21 Aug 2025 09:59:11 -0700
Message-Id: <20250821165911.79204-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821125555.3020951-1-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 20:55:55 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> On 32-bit systems, the throughput calculation in function
> damos_set_effective_quota() is prone to unnecessary multiplication
> overflow. Using mult_frac() to fix it.
> 
> Andrew Paniakin also recently found and privately reported this
> issue, on 64 bit systems. This can also happen on 64-bit systems,
> once the charged size exceeds ~17 TiB. On systems running for long
> time in production, this issue can actually happen.
> 
> More specifically, when a DAMOS scheme having the time quota run
> for longtime, throughput calculation can overflow and set esz too
> small. As a result, speed of the scheme get unexpectedly slow.
> 
> Fixes: 1cd243030059 ("mm/damon/schemes: implement time quota")
> Cc: <stable@vger.kernel.org> # 5.16.x
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
> Reported-by: Andrew Paniakin <apanyaki@amazon.com>
> Closes: N/A # privately reported

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
