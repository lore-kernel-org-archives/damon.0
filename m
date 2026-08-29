Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2C03ACEE9
	for <damon@lists.linux.dev>; Sat, 29 Aug 2026 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788030201; cv=none; b=hYS9sCY7xW3Kujz2HPtmjWw8KILDrSiKAhxrZUjX/eJw+AV9mBa1IdlWsEf7cTvbSrOJDOC8TOERimQQUbGphnXMWWHmlK37xrCGLoTc0OqUqwg8ALjbvLautWULawd9q3VFygh+bSbIztE0FoiF2yfPjGWnH+UTF9hWDc1nLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788030201; c=relaxed/simple;
	bh=TIh4DOnD+S/iXHsrfiIEXNJifWn+ISjtMrnm++DfHQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XO4K9fPAfYQ52VYho0aPnzoIQytbuOXdlYv4CV4wBwc5H5MkI//wa9KI8EHEvcabZlo7o+1sXVwuRAEXLQ68AsRv9YFd/1bfcKzSiO0JnC/K1ehFk7OPVzFKwjnHj8OTJV5RURyKVuQH2SIrqI3ZNseIQa7JQP8ORJ3hbvbmO7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIwNHWCN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIwNHWCN"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d71ae3455aso32435595ad.1
        for <damon@lists.linux.dev>; Sat, 29 Aug 2026 12:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788030199; x=1788634999; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pwBa+9bQ9e6n2dIJ1FHVXbNuvQY4O8W1fjuVGTSJWDM=;
        b=aIwNHWCNwyEDj0cmezlEMhnq28DroyDMIYH+WoRloDb12upuAXqlwRhJA0/cEEjFd2
         L6PeS3ecjhJuiU8gzw4rqEhDK0fbj6JQzhKNLdQ39KDFdZlq5t0nLGy2Ou3qTdxmlv3q
         zrZqRdnUEVVZAyu0K+ktq+R0Pcs2hwSHeULVM0ovTnWmh3Db24p5gFOQf6eyZsDWetcA
         VlCuKR7WxBpadDDGVANRKOWMAiEo10kDcqQbf0euzSYVcjliFpvdyicECec0IiGIga3e
         Y9YbRGv0EJqdBUly3EZSdJI0G3xY26fALrvtX6Ux8bxLH2IG+//PXemOpT6K6O4pebE0
         RrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788030199; x=1788634999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pwBa+9bQ9e6n2dIJ1FHVXbNuvQY4O8W1fjuVGTSJWDM=;
        b=i+ZNIlrs4P78KDW2Iw7sNh504e01PMz1IPhR7Rv1eBxH4JcGKAbZ4dcV7mGLFhrTMs
         oScCsR4ZqV06O+JO0TIeOm7KM5eyXS9EmN/5g3FN5Q+M4tsL8pTJZwkcdVXKb4JPdCgO
         5FkemWqw0b3QjEQCpZN0vcC6m+jeSzZSaXo9fk7NpPqxnP1senJZKMf5PTCJ/PkzaWgM
         3DN023f6bsi4/ogZXkjqxB1PDLipnheKKzAOjBLJKpaSN7AJIXRqz7T6HvD6Ue8n8lxX
         ck/NwEnNnDxDzoUCiBe1pHWkwhfemj+3Xuzea0ilhspgTnf/GCFf+LPo5JqvQQGwZFTN
         q4fg==
X-Forwarded-Encrypted: i=1; AKwUvBwBxPXZj5laE8BDgj5RYDnSgL/ihFjzakiz3khuhOcQLTq9/BCcJSZ+edvM0fr+Up3vzZIEOg==@lists.linux.dev
X-Gm-Message-State: AFuF++kRkwzYv8bRoTmiUGeEKYn+kcSJIp5foZzeZx8UlNiOc9iE50Ya
	BwHSvBWiUsu0ar+r7EO9M3cvvOYEa5XvHkhoC8Q4DH6s8A1quI/GKGaY
X-Gm-Gg: AYBFou1GodN0oot9Qm22dSW44zvAFwjaAAxMJCyBD2Hzfal83BlquWG/k+yAnM8Z3Fc
	6nfbb3hiPlga1fNJi6b6aXdd5V7lfIV2MR++9Pkiw9lVHbCyVoe5kgKTR9sDPrlhBeMD+3dZBkg
	91xx1va7D+JN033FT/t/ZMM5Rm2e0rnfVGtgu4GrZI5mUDbyUveYXZKV4av2ypo5n+xalEDChVr
	UW8cgSsgFXHjrH58LrUM4KrqKs0gjaU5BeVbItQdG8o/mR1t8ONAh7OxuN6B2mb+etYbtA9BmlJ
	qjYm00/8d9azX4gtPPY7zkiEtCGEnLnQp993RFNaQdhx/IawFxe2/qVN6G/UmtwAhRfUBSgd96V
	DXxt7LCpdMBQz0U35kFdywuVxTATJPRSUaZmxcixtvSQpzq4RZgb0UMsXE/nLP8M14fqbDykdYi
	hwbzUUMsv2/FBPvyTXUBs6+8b9d4JibWR/nTF4iMDiX7btm2ttkQoMGJe31fAJF1fSqWi8zP2UJ
	gpZVbvr/gNduhu/
X-Received: by 2002:a17:902:fc4d:b0:2d8:d4cc:5bb0 with SMTP id d9443c01a7336-2d8d4cc5d79mr139929965ad.16.1788030199448;
        Sat, 29 Aug 2026 12:03:19 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d9055ddfdcsm900305ad.18.2026.08.29.12.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 12:03:18 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon: fix unconditionally skip last region
Date: Sun, 30 Aug 2026 03:03:27 +0800
Message-ID: <20260829190327.17400-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829161509.77406-1-sj@kernel.org>
References: <20260829161509.77406-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 29 Aug 2026 09:15:08 -0700 SJ Park <sj@kernel.org> wrote:

> On Sat, 29 Aug 2026 16:34:26 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > On Fri, 28 Aug 2026 11:29:09 -0700 SJ Park <sj@kernel.org> wrote:
> > 
> > > As you replied to Sashiko, let's do the last region handling in every case.
> > > While doing that, let's do the charge_{target,addr}_from reset in only one
> > > place, like below.
> > > 
> > > '''
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > > @@ -2688,36 +2688,40 @@ static bool damos_skip_charged_region(struct damon_target *t,
> > >  {
> > >         struct damos_quota *quota = &s->quota;
> > >         unsigned long sz_to_skip;
> > > +       bool skip = false;
> > > 
> > >         /* Skip previously charged regions */
> > >         if (quota->charge_target_from) {
> > >                 if (t != quota->charge_target_from)
> > >                         return true;
> > > -               if (r == damon_last_region(t)) {
> > > -                       quota->charge_target_from = NULL;
> > > -                       quota->charge_addr_from = 0;
> > > -                       return true;
> > > -               }
> > >                 if (quota->charge_addr_from &&
> > > -                               r->ar.end <= quota->charge_addr_from)
> > > -                       return true;
> > > +                               r->ar.end <= quota->charge_addr_from) {
> > > +                       skip = true;
> > > +                       goto out;
> > > +               }
> > > 
> > >                 if (quota->charge_addr_from && r->ar.start <
> > >                                 quota->charge_addr_from) {
> > >                         sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
> > >                                         r->ar.start, min_region_sz);
> > >                         if (!sz_to_skip) {
> > > -                               if (damon_sz_region(r) <= min_region_sz)
> > > -                                       return true;
> > > +                               if (damon_sz_region(r) <= min_region_sz) {
> > > +                                       skip = true;
> > > +                                       goto out;
> > > +                               }
> > >                                 sz_to_skip = min_region_sz;
> > >                         }
> > >                         damon_split_region_at(t, r, sz_to_skip);
> > > -                       return true;
> > > +                       skip = true;
> > >                 }
> > > +       }
> > > +out:
> > > +       if (r == damon_last_region(t)) {
> > >                 quota->charge_target_from = NULL;
> > >                 quota->charge_addr_from = 0;
> > > +               return true;
> > >         }
> > > -       return false;
> > > +       return skip;
> > >  }
> > > 
> > >  static void damos_update_stat(struct damos *s,
> > > '''
> > 
> > I noticed a potential subtle issue in the suggested fix above:
> > 
> > '''
> > +out:
> > +       if (r == damon_last_region(t)) {
> >                 quota->charge_target_from = NULL;
> >                 quota->charge_addr_from = 0;
> > +               return true;
> >         }
> > '''
> > 
> > If 'skip' is false (region should be processed), but it happens to be
> > the last region, the condition 'if (r == damon_last_region(t))' would
> > still be met.  This would cause it to reset the state and 'return true'
> > (skip it), which inadvertently re-introduces the original bug we are
> > trying to fix.
> 
> Ah, good catch.  The 'return true' is a wrong copy-pasta.  Let's drop the line.
> 
> > 
> > To ensure the reset logic is centralized and correct, I refined the fix
> > as follows.  The comment is intended to help you and other reviewers
> > quickly understand the rationale behind the compound condition.  I will
> > remove this comment in the next revision.
> > 
> > '''
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 644daf5a1656..82c5aed8a417 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2342,36 +2342,48 @@ static bool damos_skip_charged_region(struct damon_target *t,
> >  {
> >         struct damos_quota *quota = &s->quota;
> >         unsigned long sz_to_skip;
> > +       bool skip = false;
> >  
> >         /* Skip previously charged regions */
> >         if (quota->charge_target_from) {
> >                 if (t != quota->charge_target_from)
> >                         return true;
> > -               if (r == damon_last_region(t)) {
> > -                       quota->charge_target_from = NULL;
> > -                       quota->charge_addr_from = 0;
> > -                       return true;
> > -               }
> >                 if (quota->charge_addr_from &&
> > -                               r->ar.end <= quota->charge_addr_from)
> > -                       return true;
> > +                               r->ar.end <= quota->charge_addr_from) {
> > +                       skip = true;
> > +                       goto out;
> > +               }
> >  
> >                 if (quota->charge_addr_from && r->ar.start <
> >                                 quota->charge_addr_from) {
> >                         sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
> >                                         r->ar.start, min_region_sz);
> >                         if (!sz_to_skip) {
> > -                               if (damon_sz_region(r) <= min_region_sz)
> > -                                       return true;
> > +                               if (damon_sz_region(r) <= min_region_sz) {
> > +                                       skip = true;
> > +                                       goto out;
> > +                               }
> >                                 sz_to_skip = min_region_sz;
> >                         }
> >                         damon_split_region_at(t, r, sz_to_skip);
> > -                       return true;
> > +                       skip = true;
> >                 }
> > +       }
> > +out:
> > +       /*
> > +        * The last region may remain unapplied for extended period due to
> > +        * various regions (e.g., it is invalid or has been filtered out),
> > +        * preventing other regions from being applied (those preceding the last
> > +        * region and all regions with different targets).  Therefore, when
> > +        * encountering a region that needs to be processed, reset
> > +        * charge_{target,addr}_from.  If necessary, this parameters will be set
> > +        * to the correct value in damos_do_apply() due to quota is full.
> > +        */
> 
> Looks too verbose to me.  Let's drop this.
> 
> > +       if ((r == damon_last_region(t) && skip) || !skip) {
> 
> Why this becomes this complex?  We should reset charge_{target,addr}_from if it
> is the last region, always.  Am I missing something?

Thank you for pointing this out!  As long as it is the last region, we
should reset.

> 
> >                 quota->charge_target_from = NULL;
> >                 quota->charge_addr_from = 0;
> >         }
> > -       return false;
> > +       return skip;
> >  }
> >  
> >  static void damos_update_stat(struct damos *s,
> > '''
> 
> > 
> > > 
> > > Btw, I think damos_skip_charged_region() may deserve a kunit test.
> > 
> > I agree that a kunit test would be valuable.  While I am still getting
> > familiar with the kunit and it might take me a little time, I plan to
> > work on it.
> 
> Nice.  Looking forward to your patch.
> 
> > 
> > Should the tests include these scenarios?
> 
> Let's not add new topics.  We can discuss this on your kunit patch.  Please
> ensure it covers at least the corner case this patch is trying to fix.

Okay, I will ensure that.  Should the test be sent along with this
patch (as part of the same series), or should they be sent separately?

Best regards,
Rui Yan
