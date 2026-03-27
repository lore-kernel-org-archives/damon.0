Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537B03D1CC0
	for <damon@lists.linux.dev>; Fri, 27 Mar 2026 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774599104; cv=none; b=PBT1AXhtO0rsLdJ9KnoceBkQR6je8DnfkyF4YRnxm4kl0c6SBLRXObr1AZ/YV/3D62mXLfy6kQWA2QHnQNCC+1kJUz91LdUt1QMHd8kIxIPtaujhzjMSjrtc24rxso4kmpFd+lxTJieg6CWqDFiPiHvJO0Jqo2Wtev1UvfLgMo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774599104; c=relaxed/simple;
	bh=jbmjzb0p2Bl+HveqmuM/op7qChjd3t5dsMsabQgTaj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgrCdELExS0txmH2qmXiTiTyC4mR5fAdg7Gp+tQ1mnl7qt6ZtiZkzwkxWH2S0JSSmN1/9Hp6JQswMbyeNOgmu8OWkueI7KAIBprQUUEtqSadRTR6VawzQ964FbYWsOF7hB5hDt2Ib40dxabP58DzGa9pGXKIFcCL1pSfOZicWkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dI1cHxmb; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dI1cHxmb"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c74f0c3fc16so675503a12.2
        for <damon@lists.linux.dev>; Fri, 27 Mar 2026 01:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774599096; x=1775203896; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPhsZJNBjym7EHwKD82OuY+Kr/tp7KmnERPUIythgCU=;
        b=dI1cHxmbctzfmObCdvGeOfeL6PfzaFkyTZvPVNe28GpmijTs3xoxtiFn60WzrtdlnI
         my/rY68AfHknrA3N8PQo8zvRy8zsByR8IzdLtOZ/If9wcNMVUL+6fx0kq3hh6XYOx0UE
         GYsjBx81gQ2lEBq0YYL3Zp3TJLnVp3gADjaji1FY+FAjrIxzJDAvQZcmhVLOaQkfM29G
         HCMmAeaqSNPr2Xt87Iq9vnJ4EBlkInF+Ob3Brrdw6QBSbMQ4aHLCwnaZ7LhHCpzl4z+p
         ZWvNq4fvYL1qlp9ghBrL9Dm8irUOEXtJBklKZdrVmKrh+kn9dLQ1ChCWIr/5qVNtAvpR
         /3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774599096; x=1775203896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CPhsZJNBjym7EHwKD82OuY+Kr/tp7KmnERPUIythgCU=;
        b=YG00hs+h6OSLLx1+Y5eDY2QPI/ySZfP2F3of/Q+li6Gg6XTxlBIeXi7nilTWBeXl/d
         amVY+V/3wwyqOatGu5uEc9OwLl1bXwzT8vN/6XG3Oy0byI7UUm7rFx8Uc7oChTDsSuPZ
         SwRa3lnAJobeaA4GpgEbV/8+l1gQV1m22bE4AjZiUPSx3pRa/fD/n9p4Vl/N5N56nLk0
         mjbw7iyXfIp3ZlQj3lvq0rJeMPGilswfbgUjmyYtCgzqGrgbNpGa09uJtmXCd8jqLk29
         aJ4G5bmJL1YqXduprtKAF4lXg3g3jGnNs5/sOUnXrmKiLa6Ec0on9kx4DLdz4U7rCrLz
         /ljg==
X-Gm-Message-State: AOJu0Yxn5cazphDkTJvoSGchlzTHzgwrpDVEowJgbmXwTYcoo3bnYSW2
	5Y+34YcVJtQZo4DzOw3EOPrJGqeosvL8YhTfODBeVActpnPSSLsHWAVW
X-Gm-Gg: ATEYQzyuhkr3/znFipIFWl55B97Gk4UObmOIMEyDXXuxCp4j5VZvJ20Vl3YASJc0T2f
	z3SMqKf3PAkg2Q+6snOCITMl3jH8IG7N5eiVy2Os29Gefoe1rdfGXqr1l8Xxtu/gD7hcpraBLCa
	mOgfVyiA5Lr1x9RXQojItUgt5xgkya7ogsThALekZIQPJI5agGwemjzzlzk+gMwtsYcjHc19h3s
	Pk+aPyzaretPCXXVjHmSfskYelSoKk31QgY2MhwgW+mch/R9JnKDT+kVPMs0Fpb/Df1+O+Fh+mH
	Uqut6R1EKPxQ8+09kXknjrWMVsx6P0mtlPNSD90X8TsazGN7AnUP8aa9jHQ92pdPAPyjDBkBP94
	FG3rKbgzDE4HLhnMf/rA9XC3mxjrL161k7qbcSWAjMMl0PXnuEX6TxjjV0t53zvyZFdOOLDN53p
	SJRnXqfKH9m+pcjBmGW344yUfwzI4=
X-Received: by 2002:a17:902:d541:b0:2ae:4cb8:484a with SMTP id d9443c01a7336-2b0cdcaa6d7mr18954505ad.17.1774599095798;
        Fri, 27 Mar 2026 01:11:35 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8e97f0sm51175195ad.67.2026.03.27.01.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 01:11:34 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org
Subject: Re: (sashiko review) [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Fri, 27 Mar 2026 16:11:31 +0800
Message-ID: <20260327081131.80608-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327062627.66426-1-aethernet65535@gmail.com>
References: <20260327062627.66426-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260327062627.66426-1-aethernet65535@gmail.com
# start of sashiko.dev inline review
commit ceb9522e072d53117ff67157d6f0be7d35919759
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon: validate addr_unit to be power of 2

This commit adds a validation check in damon_commit_ctx() to ensure
addr_unit is a power of 2. This prevents kdamond from exiting
unexpectedly during parameter application when given invalid inputs.

Link: https://lore.kernel.org/20260325025317.86571-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index db6c67e52d2b..6bad85a47a79 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -1330,6 +1330,8 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
>  	dst->maybe_corrupted = true;
>  	if (!is_power_of_2(src->min_region_sz))
>  		return -EINVAL;
> +	if (!src->addr_unit || !is_power_of_2(src->addr_unit))

This isn't a bug, but is the !src->addr_unit check needed here?

Looking at is_power_of_2(), it already evaluates to false for an input
of zero, so the compound condition could perhaps be simplified to just
!is_power_of_2(src->addr_unit).

> +		return -EINVAL;
>  
>  	err = damon_commit_schemes(dst, src);
>  	if (err)


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260327062627.66426-1-aethernet65535@gmail.com
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260327062627.66426-1-aethernet65535@gmail.com
#
# [1] https://github.com/sjp38/hackermail
