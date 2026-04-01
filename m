Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F863BED24
	for <damon@lists.linux.dev>; Wed,  1 Apr 2026 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775032853; cv=none; b=mWMtSsjve7IY16QswnyeFluCYvlsjmlZKRtZQLdYpKGTkmMCkAm8tyVXvU4C75CamCfPuWRsRxg49gmF1jI7LRPrE0p4CfEkPT/6lGWKiqbF96RMVTd19RM8KF1MXgUbH8C4H+4FBh1o/CSNAgWMo+08g7AmWHNrGXL/Kzh4uF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775032853; c=relaxed/simple;
	bh=zYUT3fGguknAf/By0WkANntTQD0RceBdX9n0qyVzrug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OykEzYHlwNbZrs7+hrOaIRMndP4/HCe1uir6f+X+Ziqtved9j6im+pHbpWdeU4rjoJ1Chgc6s5Zw2j1rHPFOSy2hGlW6gezj8zNlB7Pw1MFV2GcuGehASMIIA+t4U3XdcpuoznTYBbPGZGredhb3QD+umI5+ClpJSwXqIbByPD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBUXro9k; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBUXro9k"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8297e0b27e5so3255273b3a.1
        for <damon@lists.linux.dev>; Wed, 01 Apr 2026 01:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775032846; x=1775637646; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6iijgchx+dYS5ecxF7/o+lyVBYG7gkxzY2woIbsGAc=;
        b=KBUXro9koRn8i8sdd6dFqJzbFsUvK4naQaVIDs1VO/g1hTpVXmEj4luo6b7bCzN128
         mnGtOW3Xj07bsOdls5zOnqVv9JcttITxg72WoLYu1nlkGYuzrHqvcSDuduy/uGFwohL2
         +/yeS0L68VQ6rpXtTYW5XeOCud5avBqJdRtn+yceCdT8qYmI5V2/oH3KwPOciQRXZ/h7
         GBDIh9OdsW+PZopKLVFg0Ulqnkcr2yHKylUMTPhmD77fqMiNJqWqhg9W8pEHsBjcEER0
         Pmji9pLIKCoBFGk5HP8OhkSmy6E2Sgk28ORYET2SQ3Cg6AomT5iJnucVtKoFCBXWkZtw
         Cskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775032846; x=1775637646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B6iijgchx+dYS5ecxF7/o+lyVBYG7gkxzY2woIbsGAc=;
        b=b4n99qQlJv8K+Qu6/TgPPbKQNUlv/OSg2pvgwBHZ2tnlx9qVkTOFS5E+IXS/d6usD7
         ICT4DODTm9ncy7zN/W/jYMz3pTiBfN4l4RM9YyH8ECg9X6+pwRAAvTze3m/GUTeOZv26
         VY7RttOiVhzGOGBf+BumYmklbFQZPZd20xu9DTYLnIx7yiwswgie1QpSZNNqg0NJgnei
         fRjvH13l/J0w5kTAMeMY3xvaaMNZaNT+jm4ISxxaPPiYgVVa2snVEJpk9SMQ7iFD+DWs
         k710ygHXaQYIdgcLtDY0yttLGgm5dzXkW/zj56WE+4ya06p2tanAfUa/FVGp6RfWc5BM
         XRNg==
X-Forwarded-Encrypted: i=1; AJvYcCWtiu3rtFVPF/TAy7d6iqvR9CNr/oXRjsisdMg/gRdgleQOi229mwghtYE7D1aNQv8gPbjuiw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6doo7msuoRN0YHpEobltsyBI1CiT/NApt+U7PsboXwOHBd8SX
	Cvuf3XXh6yeng2edlBOnyl1yy8zvuO7xeEXl+0F7eGzFiw0n/YfKMGwJEGsIlQ==
X-Gm-Gg: ATEYQzxD6zvetwoj0HGUXzjfDavv2WffDSQcQfzI7Z6TcIii/SfF0Btbh9lmEybzdMl
	YIukKZOtdXT3vxMcazeZCmaZGo4iNhjaZWBvVcyZEMWXCTDodai6znt5e6mUaYjiw/Nr42DP91X
	7N9kKGdzzZ2vHE4zO6PyVpjDvZXLg32lOtcfaQWy63iRRwvSonxFmOMN/fp4RgOMO7SAMxmwMql
	7/43TOYfHxv9BukiYRN4kugf3t84k2TdbVTI+4B/DPQO92JiVegT/gLbK1k+Ckt0oYoUQCsB6WD
	7/nf7Orw8OoKqG3MyVXy9dH0aFZqgpVn8wLms9RXrktxH6xKV2xLZ7PCMu8Uc/xOluWZvlR8ZDn
	t/Wa+NKbTM5CVUNS2d5vRN+lawtzTiGWDUDYexgTnaz1Pc3x4HQNcfmLCGhyDQdrXdyII/S+LkF
	/IJYYvHvwtvsIkR9sDQRfdC8Uu/j0jJSvSFLjLa74oxVw/uzTnUe0=
X-Received: by 2002:a05:6a00:3c84:b0:82c:d7c4:4c6b with SMTP id d2e1a72fcca58-82ce88d81f8mr3317802b3a.11.1775032846289;
        Wed, 01 Apr 2026 01:40:46 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cd7d0410bsm5147718b3a.33.2026.04.01.01.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 01:40:45 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: validate min_region_size to be power of 2
Date: Wed,  1 Apr 2026 16:40:45 +0800
Message-ID: <20260401084045.15473-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401010157.86136-1-sj@kernel.org>
References: <20260401010157.86136-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 31 Mar 2026 18:01:56 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Tue, 31 Mar 2026 15:32:31 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> >
> > [...]
> Seems sashiko found an issue, and you are preparing the next revision, right?
> Assuming so, I will skip code review of this version.

Yes, I'm preparing the next revision.

> > 
> > Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> > ---
> 
> Weren't there previous versions of this patch?  Could you please add changelog
> here, from the next version?

Thank you for reminding me. I will add a changelog at the comment area,
and add this to the commit messages.

    This patch is a follow-up to the discussion in [1], where we agreed
    that the validation should be done on min_region_sz rather than
    addr_unit.

    [1] https://lore.kernel.org/20260330233343.4083-1-sj@kernel.org

Best regards,
Rui Yan
