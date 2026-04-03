Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FC964
	for <damon@lists.linux.dev>; Fri,  3 Apr 2026 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775205087; cv=none; b=VRiYYH079Xt/QrH9L64zMd2uSVSNrzqAHO5LLvJ3emfoiwxMmWuB3zP64NJ7fzI5WoWGW1NfUW4kfQO4FYo10p6D72MZXReXJ5DHg4W/B2anh7i94w/pe2H7npCre6+HFpDiNJBWWrWW7bASEBPMiV0wTlZzPuivWNacVf8U7tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775205087; c=relaxed/simple;
	bh=GIYhFPGcWs1WBugRAJoUDfnh3yIu0fFeanjo8LRgJTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWgtVvGmqb32wy0I/Tctzd6VyELm/NMavmSY1l07Tw8MeJE2I4WewsjPV1aDnnqWTE0BuYSBlVSjernpTkXuWP8JcXMPyRRZNNZ0Unrb15peteop0QwAwB0m//SZGv87cIeBPBnan4Pq9XPPxt1Hv3MjSJnA8qMEC+w7zpndOcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYBiC8hB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYBiC8hB"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b23f90f53aso15940295ad.0
        for <damon@lists.linux.dev>; Fri, 03 Apr 2026 01:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775205086; x=1775809886; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPHnX95L4zARAb9iKb7/VH3eLKj/XM5UcYBpATOx7fI=;
        b=UYBiC8hBej8PX7tHLZSptwg+qrjkhsv7zkno5KNdXT/WmKfDQudh8cM3Q2qKGnkVsJ
         i7HKL7vFSpVUIX4fDFsvZcNPT/AdCTHz/OWs3nO4vYG1TmgAQB5pxQdc9Zz4HXh4dGfL
         DA5Vtho2+rgdWWLyyKrZ7vSAg2xcBes3YbSc23XegxT0FxEjv+2rofrv4/TIYRtJP2+U
         DaqslvDGUpRHbl7FqMU0Z1VSYp+jo5FIGKT97E1ZwsaJkSWDSBd95f+MdbJzKtMvEUq8
         M/S8hPUs8uaMsv4dYUFImEsXezdW8LJ0h/KBCuTwZT/6TilSwzrTSRSpIVrzEuFZMt/L
         zp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775205086; x=1775809886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vPHnX95L4zARAb9iKb7/VH3eLKj/XM5UcYBpATOx7fI=;
        b=beWfoJGn7VCu43K0bjBd3znFmgJyBgKCU5aE0Nny9rAmrV5VYmLQff1UkGQAQAa+s7
         LIFbhKbj9n0Wo5dL9awUG1Jsy8mQtV57KQvhRzNsBx00xaxrRgBF/rkvKkctlVZsQnQr
         LI8faxHmHq8GrZBbuXf5JNL6hGx158UPqLBqNOAlWPpWno2UttpO6Jsc6nmANUQoQ7tK
         kkKtHzaQLBx/jxkgC0K+ZEd289/MoPAjfnunxs/fKsF8LUqc7hFRdmg/sr5hehBS3YNS
         YrplrbSJwUdlT71u185GC0GtXHXO4KUqF272YY56yDk1vb+wEHXhyNTL+EIusX5UGby/
         vJtg==
X-Gm-Message-State: AOJu0YwDIM+vqH7PtG+/YAVaFn9/KAfGvEDIm2rTRI1jcWPdKAJgbBdE
	1Dul8XOR//8CNzbZvZR1lJqFOmTZxWofjax8ZixcM0TnxFHfjEx46eUI
X-Gm-Gg: AeBDieuInkl5ozen0xhy8gN0bHiadobYzLy3ircy4aLkmT04KppVEhTyO9MI0rZeCTH
	R59exNiZvM+pH0VTU1Vrm70E8Fglw3fXKir0MbHhqc0+mOy3QIJozqO/Zz8Bf3jhWHiyeZfp2vT
	LUzL8U9d/RxHEIe/uba4DOWoczsmg9osSEGNQIa7Q/bCiZMLqm01hstDdVktgn/r/miYRzaUNNq
	AfaHhc+Ixt4AtZdseLmgcTvhKvm2ZDsm7ZKiM2OlRGlBf76VerjVeMnnf73aR1i/pXfqpi+IO1H
	plMlZtVi8nPj4b03zDX53IVPUeivVS39DbdAJvsHXctOSGKNqz0nGJNdwvWrOFob8eALOe+sK0M
	x5tQuPXEASzP1GxksWwPYqdTBbZIeesxvSHEaSLBpZmiam+hjod2ecvWFZGxrsLtHqywh4MYP61
	D2qhKErDcQ+K5rU7nhwZUoLLo3swb0aI0MEBUWO+pGpZMq0dhg39k=
X-Received: by 2002:a17:903:4b07:b0:2b2:51ed:4522 with SMTP id d9443c01a7336-2b281833d68mr24607425ad.47.1775205086057;
        Fri, 03 Apr 2026 01:31:26 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d280sm54193015ad.17.2026.04.03.01.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 01:31:25 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org,
	stable@vger.kernel.org,
	yanquanmin1@huawei.com
Subject: Re: (sashiko review) [PATCH v3 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Fri,  3 Apr 2026 16:31:25 +0800
Message-ID: <20260403083125.5654-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403052837.58063-2-aethernet65535@gmail.com>
References: <20260403052837.58063-2-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260403052837.58063-2-aethernet65535@gmail.com
# start of sashiko.dev inline review
commit 525a0116b6d91612e679b30ae84e489a7540edbf
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/lru_sort: validate min_region_size to be power of 2

This commit adds an early check in damon_lru_sort_apply_parameters() to
ensure min_region_sz is a power of 2. This prevents kdamond from unexpectedly
terminating when given an invalid addr_unit.

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d729760..3fd176ef9d9c1 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -294,6 +294,11 @@ static int damon_lru_sort_apply_parameters(void)
>  	param_ctx->addr_unit = addr_unit;
>  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
>  
> +	if (!is_power_of_2(param_ctx->min_region_sz)) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +

Instead of adding this early check here, could this be resolved by fixing
the stateless validation in damon_commit_ctx() directly?

Looking at damon_commit_ctx(), it currently sets dst->maybe_corrupted = true
before checking if src->min_region_sz is a power of 2:

int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
{
	int err;

	dst->maybe_corrupted = true;
	if (!is_power_of_2(src->min_region_sz))
		return -EINVAL;
...
}

When this validation fails, it leaves the active context marked as corrupted
without making any state changes, which causes the kdamond thread to terminate
permanently. Moving the stateless is_power_of_2() check above
dst->maybe_corrupted = true would resolve the regression for all current and
future callers without requiring duplicated validation logic at every
call site.

Does this missing validation also affect mm/damon/sysfs.c?

When a user starts DAMON via state_store() -> damon_sysfs_turn_damon_on(),
the code calls damon_sysfs_build_ctx(). This calculates min_region_sz and
then directly calls damon_start(), bypassing damon_commit_ctx() entirely.

Because this bypasses the is_power_of_2() checks, kdamond can actively run
with a non-power-of-2 min_region_sz. Core DAMON operations like
damon_set_regions() use ALIGN() and ALIGN_DOWN() with min_region_sz, which
perform bitwise masking that requires the alignment parameter to be a
power of 2.

Could this allow userspace to trigger incorrect address boundaries, massive
unsigned underflows, or infinite loops during region splitting?

>  	if (!damon_lru_sort_mon_attrs.sample_interval) {
>  		err = -EINVAL;
>  		goto out;


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260403052837.58063-2-aethernet65535@gmail.com
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260403052837.58063-2-aethernet65535@gmail.com
#
# [1] https://github.com/sjp38/hackermail
