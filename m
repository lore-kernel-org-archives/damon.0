Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E065285406
	for <damon@lists.linux.dev>; Fri,  3 Apr 2026 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775205205; cv=none; b=nN9ZlZmTuSdK4ShLxHbDxbr6Ilhpy7H40xJNkulDbqxqgsZ2FI+STX7LMwoFbXVZ4hLou0shssaZ3W3hdUvcVYD5dK3PLXQYUkgnzfgQ+TZ1orYaSEHYsjMBQSrwEq/kV7Fh453Nlx9uYpv5Ppae4wUE0FB6EfD0Tu89Q65U24k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775205205; c=relaxed/simple;
	bh=DLsbyElg3cqs7sB8NU6Lf6TtGjjSAtMF30jU9YxsTkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbeJrkuRnEsBnNA9qI46rx47YYoX6dyzQKZ0+Bn+9XrW9WlmWCUEEBJGMgmla5PgvqMeFXaWHD3DaeulJchk1eum3Djsb83Uv0nMKqWcqNtb27fKXEQfTcVYD7cfTrYXFrLqF/0n7VMvJn8NFMHh0Vo2+/D6jmm0nFPP0qW/q6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOBVkeiV; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOBVkeiV"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so580611a12.0
        for <damon@lists.linux.dev>; Fri, 03 Apr 2026 01:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775205203; x=1775810003; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6bWdEuhaXAxPBHptBvlmQsfSLSE+qPqms2g9XHTbnI=;
        b=JOBVkeiVAzAWJfo0UZIxjuxjPSvjBYVS46cq+jrR/HhTaP3C9XBrobjoCNiKUOCLrD
         uf7TCqy7CbJiLwfEtYyJF0wRExwE8vhnc/xlPwfdGWusbNDwsIambGPxDqURQzvk5/mL
         9ZunaMqyh94s09uUhT1GrvisI4j2hWBJE7W1X43Z9UXGDBnFrU0qdra2XYjlY/ZTtLn+
         t5GTvMiu4YjBpgmQqbuig+mixLoq/YDx2SFThE/8J9M83N0MlIStc0w+UBnOrsaQI07c
         vBgbWCpCL6oBqOWkBbz3FPn77hhTLcA1TGRR4zKyAJnzCgbeKVlPwOy19EZKdufJU+Mv
         OasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775205203; x=1775810003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s6bWdEuhaXAxPBHptBvlmQsfSLSE+qPqms2g9XHTbnI=;
        b=e7kYyKkXlSAZ9v/LQRXlNnh2WhIc5wKlOTwNqPSV+bjvb05SUDj5ag8SQUF9+ShtKl
         2z6W2GlPSdv2cDFYCiTjS2aDNSTjfx6syRceoGn1y4lnAYMQMu0mt1969tJ297zbppHR
         A9nB3jxDKWyHpdE0bMkplGky9r/2Onj4qZbA36QqdYdwsbVQn0o2WCSEX04E0P63VQGI
         DoFJscbmM0Z2Qw9RVePj3F0Qgz+5J4swh4QkYNJ2Ml1qIDbtYlZbpkyE/PUeUJ03oRNW
         tTSSw8t9HENv/fuhtpp4rDCQP74uP0KAvOoctRpnyjbXXxKtLr+HiBoOVaNrLM3a8R0c
         igLQ==
X-Gm-Message-State: AOJu0YzSqCs0vwKuDP3FHsIAU64Y6VUdONdUAPSl9OJ1wmtMjAG4cvp3
	ykj1s5J6LFRiUJVbGu5gD45kAld6bFm0tjm/h16Aoi9QKYJna07mp419
X-Gm-Gg: AeBDievps1oz8z5O7+YKUHgBUWBirDRvhwG0dHvhfwXxgY0Cus6d9OS71MTBdGHIDJx
	E0Q58LckkZDtfVHLav+War+l+kNjRQJNUTfP9+BM2n/qWygoLyc6Sf638IIn88j/+R+mpEwzWNi
	cYX/ui0QBrAMHH8gODxt6k2Jrx4uWwXMu2nbMDawsrpqELWFyuLNqlNpsw9R3WPhbzKcA4ngYld
	90ZezBBErlgzlIe24dnkdYBoilQcNvkHFU+G8VS4zc9YJuoZ/pLfvjR6eq6jDobBrrZJWb9XWeU
	PRymsFIPLiqBiqdDVz9AR0YtPHQIyY8Le7H03UErzF80suGeRp2Q1/NGE+gdggHbrlDBEtI/sRY
	c09hQfkZ0VWMWKDSNYmRUaihFNQ3JIEbST+01GJEl4IQInBypXhGOx2Uji7K2rCHfyPY7FF2AWh
	I9NIgrKZhsKLx7Rl+NiDbszfRk8505yamtvq4Z4YxYSI1lys3KG7Q=
X-Received: by 2002:a17:903:1aae:b0:2b0:4a57:e480 with SMTP id d9443c01a7336-2b2817da2c3mr25467465ad.45.1775205203471;
        Fri, 03 Apr 2026 01:33:23 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d646sm51793865ad.5.2026.04.03.01.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 01:33:23 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org,
	stable@vger.kernel.org,
	yanquanmin1@huawei.com
Subject: Re: (sashiko review) [PATCH v3 2/2] mm/damon/reclaim: validate min_region_size to be power of 2
Date: Fri,  3 Apr 2026 16:33:22 +0800
Message-ID: <20260403083322.5852-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403052837.58063-3-aethernet65535@gmail.com>
References: <20260403052837.58063-3-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260403052837.58063-3-aethernet65535@gmail.com
# start of sashiko.dev inline review
commit 28b6de17622e17753e02ff606413650ad898f09d
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/reclaim: validate min_region_size to be power of 2

This commit adds an early check in damon_reclaim_apply_parameters() to
validate min_region_sz and return -EINVAL if it is not a power-of-2.
This prevents kdamond from unexpectedly terminating due to late
validation failures.

> The damon_commit_ctx() checks if 'min_region_sz' is a power-of-2.
> However, if an invalid input is provided via the DAMON_RECLAIM interface,
> the validation failure occurs too late, causing kdamond to terminate
> unexpectedly.

Is the root cause of this unexpected termination in damon_commit_ctx()
itself?

Looking at damon_commit_ctx() in mm/damon/core.c, it sets
dst->maybe_corrupted = true before running the is_power_of_2() check:

damon_commit_ctx()
    dst->maybe_corrupted = true;
    if (!is_power_of_2(src->min_region_sz))
        return -EINVAL;

If the check fails, it correctly returns -EINVAL but incorrectly leaves the
running context permanently marked as corrupted.  When kdamond_fn()
observes ctx->maybe_corrupted is true, it explicitly breaks its main loop,
terminating the thread.

Would it be safer to fix this regression by validating inputs before
mutating the maybe_corrupted state in damon_commit_ctx(), so that other
callers remain protected from unexpected daemon-crashing denial-of-service?

Also, does the DAMON sysfs interface bypass this min_region_sz validation,
allowing kdamond to run with invalid alignment?

In mm/damon/sysfs.c, a user can set addr_unit to a non-power-of-2 value via
the sysfs file. When turning DAMON on:

damon_sysfs_turn_damon_on()
  -> damon_sysfs_build_ctx()
    -> damon_sysfs_apply_inputs()

The code calculates ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1)
but lacks the is_power_of_2() safeguard. It then calls damon_start() directly,
bypassing damon_commit_ctx() entirely.

Since DAMON heavily relies on ALIGN() and ALIGN_DOWN() macros with
min_region_sz, could a non-power-of-2 value produce corrupted mathematical
masks, leading to overlapping bounds and memory corruption?

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 86da147786583..2747eef5919d1 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -204,6 +204,11 @@ static int damon_reclaim_apply_parameters(void)
>  	param_ctx->addr_unit = addr_unit;
>  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
>  
> +	if (!is_power_of_2(param_ctx->min_region_sz)) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
>  	if (!damon_reclaim_mon_attrs.aggr_interval) {
>  		err = -EINVAL;
>  		goto out;
>  	}

Can concurrent modifications of damon_reclaim_mon_attrs.aggr_interval via
sysfs cause a division by zero oops?

The global parameter is checked here, but it can be concurrently modified by
root without subsystem-level locks.

Subsequently, the function calls damon_reclaim_new_scheme() which executes:

damon_reclaim_new_scheme()
    .min_age_region = min_age / damon_reclaim_mon_attrs.aggr_interval;

If a concurrent sysfs write sets the interval to 0 immediately after the
check, could this re-fetch trigger an unhandled divide error?

Further down in damon_reclaim_apply_parameters(), the code calls:

    err = damon_set_region_biggest_system_ram_default(param_target,
                    &monitor_region_start,
                    &monitor_region_end,
                    ...);

Can a data race on monitor_region_start and monitor_region_end bypass
bounds checking?

These global variables are exported as module parameters and can be
concurrently written by userspace.

When passed to damon_set_region_biggest_system_ram_default(), the function
validates the pointers:

damon_set_region_biggest_system_ram_default()
    if (*start > *end)
        return -EINVAL;

Without READ_ONCE() wrappers, could these values be modified right after
the validation, satisfying the forbidden state where *start > *end?

If this happens, the invalid boundaries are blindly assigned to addr_range.
When the region is later sized, damon_sz_region() calculates
r->ar.end - r->ar.start, resulting in a massive underflowed unsigned long.

Could this cause an unbounded OOM loop inside kdamond_fn(), where the
region split condition while (damon_sz_region(r) > max_region_sz) executes
infinitely and constantly allocates new structures?


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260403052837.58063-3-aethernet65535@gmail.com
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260403052837.58063-3-aethernet65535@gmail.com
#
# [1] https://github.com/sjp38/hackermail
