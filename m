Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE69411A09
	for <damon@lists.linux.dev>; Fri, 28 Aug 2026 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787917855; cv=none; b=VCxRdOnLAokSGZM95B7I42iqvR/zfTHduDHAYFEzbGQekJLJ6ZXFn3/gqhX4/vgcOhvq71NSp7mdSvLJt2JUg3zoJ39tIrVk6nsuPTJFp3qWgb0aHOWWPGVKYwwa6nS8aYTblxtGO0rV7XexOmvES5Zn4dfQs2zPke9meQqFw2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787917855; c=relaxed/simple;
	bh=elMHYF0Q0z8GRQDyDtakJ6okP5dn4Lv1DZPyk20A468=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lN3ecmnjTRZuGAy525dPSU+aXdZ+fnaoYMy4lxsKM+c/EvBZyVTxRBOaDkWMzVHogzHnRd2KF2FJ4UYMcXvNweospWiFu8fSQ8dbSBqb/3/6ZXMQRHfD50v5u4Kf0FGOIcU8j1b77g56OCyvjNnN/8iw3FkKRGIxVYssbo5Of68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp9dqrZq; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp9dqrZq"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8568e3ecfc3so372211b3a.3
        for <damon@lists.linux.dev>; Fri, 28 Aug 2026 04:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787917839; x=1788522639; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nYL1x1PhkxOLSfcHaoOTRQlZQow6faObjxE2pbTIVVA=;
        b=jp9dqrZq9q+L3/0OeMpw2teLEyiCyMnZHwVBYXhkmJBg55uLaFsjH6nZXOp3ZP3PnR
         8bPJyoA5eALax4jBScx47+fiD8gwjmt3hPT/DEVsiuJsWiImO0KE0RznpS8dTrL3UOcD
         vupHG3K21Kw92Mzp32FZktB7YdN1aqPGtZipfLspbz5miB5VVSPDhFH7jkJ9tVndCs7h
         dRLM3zxBFu0opk+EhhrTbT3bJDjRClzpnT7wUoymR0nNFXNa5JTNMUIXICDECRlSm/Fq
         3ybXRCTJwMlNnj3nXGxrARCLJxpgMQI+DxAeNuQ/kn6z9kwO8vNZJOgIDynBEgI3Jeop
         2cJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787917839; x=1788522639;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nYL1x1PhkxOLSfcHaoOTRQlZQow6faObjxE2pbTIVVA=;
        b=lZUScdcPI7KARDRtbQGIbf/rqkia/ToV5d388pJ7OacwrtZpUmb9BmcF5urPd4qbFY
         6IWVc7Qmq0HoIyGfWRo035evTMq9h43TiH9u1lCPNLPlhNETEdMZVzpr5c7VUtKdVHbi
         zgOZXtw2NeLjmC93EEjkQ6+3q+IVQrTCma5xjFjpD8YjQLtNX57X+TTfydQALcyTBVBK
         jWKFTNokmzYz0iNZfSYKDqmTHYvq/nmOnhsdl863teqr9BFCJxf71pJJ5gdppr1YicyW
         aTmqHvFEv9i4Bb2p1UZavszL3nO82dCaePWsvVlh2uOgjjMn4yRZtiakSPrfaFbRcyTt
         ifhQ==
X-Forwarded-Encrypted: i=1; AHgh+RqI6lxhKH82p7eHnzgXPHtf6rukU8kfauuhTJnRP7Tox5MGCuYt3eUtW2YP5pzDjyVdNGI6EQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nIcUDNceURfijl5nfUMhrjNnfVJNrSh8W07lvsPL5nrI1Nvebg
	1+j9FLnLM6RU8VeJ+//hUElxvymUVSmDq7leU14bRfoumKxXSCRswRgm
X-Gm-Gg: AR+sD11B8+m1Exw3fDc6kSP0GAoQNQEjsewoeUzPNxjjN64Xnuobtbr6vKgVdov2dMH
	HdwVz4w9LGjNm63bCz5luV64gjNUF2sghdzttbknFLFtPDm8P/tH432sedbNmekYqL8IOAAgY98
	08aOaBu2lGaFZazRcOb8ERCM+g3fGLOHyHIOHqfF4+7NILg/eT5LrdKPwoIRImCqCB5CFTFKyW3
	2gyzt+ePO59q5g2MAe+AgYMO/OGmPf1gISo51uCrLQj6dtvyID5DDAOxFJujrOZFZfC4arzNjon
	ZNKvAB/UqA5a5a5pnGbJlLHnUnKeTGCPA3djhNiHODIj1Qlpz6qYOLAsKQ2mZ6sSkCSU52luep4
	TFlOI9QQe/s6lMlz9VtsgctUYgRVE18GmtVCG3ttXdYgvJmcZeFfMS2CHwIWJSV0bD1DO1+24t/
	CdDIMA6/G3UnZwcqRyxOxbeVhUD8adTKPKhYx6s4AEHyeiAhqVGf4jKwfiYotq4e8i7g==
X-Received: by 2002:a05:6a00:b85:b0:84e:2382:f4f0 with SMTP id d2e1a72fcca58-8562839d75amr13276129b3a.4.1787917839411;
        Fri, 28 Aug 2026 04:50:39 -0700 (PDT)
Received: from celestia ([2402:1980:88cd:27c4:5897:46d2:587d:19e7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-856a2ea75cfsm454374b3a.34.2026.08.28.04.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 04:50:38 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sashiko-bot@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH] mm/damon: fix unconditionally skip last region
Date: Fri, 28 Aug 2026 19:50:42 +0800
Message-ID: <20260828115047.332978-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828090410.40AEA1F000E9@smtp.kernel.org>
References: <20260828090410.40AEA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 28 Aug 2026 09:04:09 +0000 sashiko-bot@kernel.org wrote:

> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 644daf5a16560..21dc6b086c42f 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2347,14 +2347,15 @@ static bool damos_skip_charged_region(struct damon_target *t,
> >  	if (quota->charge_target_from) {
> >  		if (t != quota->charge_target_from)
> >  			return true;
> > -		if (r == damon_last_region(t)) {
> > -			quota->charge_target_from = NULL;
> > -			quota->charge_addr_from = 0;
> > -			return true;
> > -		}
> >  		if (quota->charge_addr_from &&
> > -				r->ar.end <= quota->charge_addr_from)
> > +				r->ar.end <= quota->charge_addr_from) {
> > +			if (r->ar.end == quota->charge_addr_from ||
> > +					damon_is_last_region(r, t)) {
> > +				quota->charge_target_from = NULL;
> > +				quota->charge_addr_from = 0;
> > +			}
> >  			return true;
> > +		}
> >  
> >  		if (quota->charge_addr_from && r->ar.start <
> >  				quota->charge_addr_from) {
> 
> [Severity: High]
> If a target's last region straddles quota->charge_addr_from (meaning
> r->ar.start < quota->charge_addr_from but r->ar.end > quota->charge_addr_from),
> does nesting the damon_is_last_region() check strictly inside the
> r->ar.end <= quota->charge_addr_from condition cause it to bypass the reset
> logic entirely?
> 
> Because the unconditional r == damon_last_region(t) reset at the start of
> the function was removed, the code now proceeds to the next block where it
> attempts to skip the prefix:
> 
>     if (quota->charge_addr_from && r->ar.start <
>             quota->charge_addr_from) {
>         sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
>                 r->ar.start, min_region_sz);
>         if (!sz_to_skip) {
>             if (damon_sz_region(r) <= min_region_sz)
>                 return true;
>             sz_to_skip = min_region_sz;
>         }
>         damon_split_region_at(t, r, sz_to_skip);
>         return true;
>     }
> 
> If the prefix length is smaller than min_region_sz and
> damon_sz_region(r) <= min_region_sz, or if the subsequent
> damon_split_region_at() fails due to -ENOMEM, the function returns true early
> without splitting and without clearing quota->charge_target_from.
> 
> Does this permanently leak quota->charge_target_from?
> 
> If the function returns true early without clearing quota->charge_target_from,
> the region loop in damos_apply_target() would naturally terminate since it is
> the last region, leaving the cursor permanently pointing to the current target.
> 
> In subsequent time windows, could this leaked target repeatedly trigger the
> same early return, causing all other targets to be skipped permanently
> because t != quota->charge_target_from?

Thank you for pointing out this issue!

I just wrote a v2:

'''
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 21dc6b086c42..02a4b2edcc4b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2348,14 +2348,8 @@ static bool damos_skip_charged_region(struct damon_target *t,
                if (t != quota->charge_target_from)
                        return true;
                if (quota->charge_addr_from &&
-                               r->ar.end <= quota->charge_addr_from) {
-                       if (r->ar.end == quota->charge_addr_from ||
-                                       damon_is_last_region(r, t)) {
-                               quota->charge_target_from = NULL;
-                               quota->charge_addr_from = 0;
-                       }
-                       return true;
-               }
+                               r->ar.end <= quota->charge_addr_from)
+                       goto may_reset;
 
                if (quota->charge_addr_from && r->ar.start <
                                quota->charge_addr_from) {
@@ -2363,16 +2357,24 @@ static bool damos_skip_charged_region(struct damon_target *t,
                                        r->ar.start, min_region_sz);
                        if (!sz_to_skip) {
                                if (damon_sz_region(r) <= min_region_sz)
-                                       return true;
+                                       goto may_reset;
                                sz_to_skip = min_region_sz;
                        }
-                       damon_split_region_at(t, r, sz_to_skip);
+                       if (damon_split_region_at(t, r, sz_to_skip))
+                               goto may_reset;
                        return true;
                }
                quota->charge_target_from = NULL;
                quota->charge_addr_from = 0;
        }
        return false;
+
+may_reset:
+       if (damon_is_last_region(r, t)) {
+               quota->charge_target_from = NULL;
+               quota->charge_addr_from = 0;
+       }
+       return true;
 }
'''

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260828084737.290024-1-aethernet65535@gmail.com?part=1

Best regards,
Rui Yan
