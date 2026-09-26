Received: from mail-pz2-f24.google.com (mail-pz2-f24.google.com [74.125.228.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED203822A3
	for <damon@lists.linux.dev>; Sat, 26 Sep 2026 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790456843; cv=none; b=F09Y8A7T3LUZkjrZlxf+COTmfXI5ud4qQCTe2sfdEPGH1ek5ZLHcIY6yv5gsUjpUHJxvcUIjI8kRRcsEfq/Xt/Og/tWRFjla9zoW3ktVaOGBXpflhfboFctpD6hURsLyw251GkSIEr0dPNHpL4ZO8PrzLBZtLtZRSRN3K/oppFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790456843; c=relaxed/simple;
	bh=zM/rdveoAKUL0koww0d+01SZ9/01sHGGtOdBr5Kj+w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1czlohSPXh99LDCeBDYIzjW6gVhUj9C/OOdTuaT6wO/fW0rFeVuWvBLvl6lzEALtQET9nCP7Wu2sjhKiDOnE9rBvhwog5igwcdC+chCW/bcBGo8XKjsglEu5YNpdX4B+PsiomQsG6/kub0iu0tVYxHfMpHcSTnPCsXL5Wc/BUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti4oINN5; arc=none smtp.client-ip=74.125.228.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti4oINN5"
Received: by mail-pz2-f24.google.com with SMTP id 41be03b00d2f7-cc745abb731so736095a12.2
        for <damon@lists.linux.dev>; Sat, 26 Sep 2026 14:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790456842; x=1791061642; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bpSCnKLdDqOi9AdxZc7ZAonemUZupk1aEtdY90Xtb6I=;
        b=Ti4oINN5cVPT1h5VRv8YHTH/WX0KDDtXXN8T+9G4CESSlRiHvEWYOFES2+cbXOA16a
         XQtkIo5FJbTXKQ5pz4ULBHzy8dJMbjCCbCkanGaux9eLr4it1y7pNoB51I2xMdYkxQ3V
         mlBnSNxK6j5olfQMXpQrL7VXA7NJ9f9uc+KuGbglHzoImprMtvGZeiHA+X7vRsgT2Ocw
         qzskEWRFDaZ9FQ2Mf6DtPdsMnJePHGzI+hpj7Ndq3Yc2ux605Zk4PSfBoUxyFIRh3iYf
         UtkVwAFKyQbMGJRzObdQ/TsNfXFXEO17PUJJStydX8Xt/8f9AZ507vpWYKOVpFL8vNix
         giug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790456842; x=1791061642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bpSCnKLdDqOi9AdxZc7ZAonemUZupk1aEtdY90Xtb6I=;
        b=r8XX0ysewjhgzsN2hygrlAA++YhnLt/UjF710Gbe5PErZdh3wT8O1FOq5FN9LcLBjK
         os0cyV9+fD2/m3Q41Q2QcECpMifHKXa6woQko6NcdOrbh9rVMuKxNiVGy4YwAV4AvFyB
         XiM/ARnktnizE37An+Jf9VjnP4hgeWnmUM5ho/8H7md1a/FOVEWMfehdLgpxXisPgc89
         5AiI0S/Yie2SKGq6UapjsQKZQOxUSZ9zLrEozcn3GLV1yjAs+MoKKItLwWunvuMS4wjt
         fU3a42AlXAG6/d41Qy+DEsOeEGdEjnzV9nUYKDp3YLLZYIHHkJhQQHZ79xY2vI+jAMqq
         VdEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJlNustJxKT+eXt9TWH1ASwvls9IaVGqRE0pB8dgLFX4dqWDCRX3ExY6NswxyPg0NSniEp2g==@lists.linux.dev
X-Gm-Message-State: AFuF++nreyzVx2HDM5edXfqOAsBEpUq4BgqCS8ZmtsCsb0A0MbRCaNVS
	zBh9M8QqgFJEgdYjRZq04WMNMKFBrsdjebmGAnEXhsrLrwofonMqYw/N
X-Gm-Gg: AYBFou3LVzQ8tfALzZfdXN6+9hyIx4XXYZHwuMgizeJZZ/w1/szuFL9MbJBMWV9kgIN
	eq3+JcGnc63NiRVh1XFkqRrvHliyksRNYT5FrERXtOl8j2osI2ws34cClJSuhNYWleSdcy+wHNl
	FKy2MZll6sz9vOLr46jiMuXJWBFoOM9SsYgvrqJlU4KCv0Bu8mzzpVosmM0gUJHPRtH6GJcAkde
	DE5FxllnqNpxjyps9fothOWYe0/G6JwgnZ4iGcD5pWrVvJxHBc2/rpJ+/Hh+nGv80vD000eP955
	+fQz7IIhN1jN+L74gWjSPQOucTs7AI76wepxcDBY7+PVfz/04qLFXfQT/E6Et8uBNn+JkUA7bCZ
	ByM/g5wqz4Eouoa/fsnnN4AzWvmu1FyHvJ4ZCtZBATANMRz2/a6bh9VMxTgkg9Xh+NUpKNgCDCF
	FOcAQ3tbWVSsOic81mEOkzCexqVCvENGErl/fNptBoX+hp2ur1wvQldg1vcPlN+mpulyDPPkz+
X-Received: by 2002:a05:6a00:2988:b0:87c:f67f:f7d3 with SMTP id d2e1a72fcca58-87e95b5ec2dmr7070362b3a.0.1790456841899;
        Sat, 26 Sep 2026 14:07:21 -0700 (PDT)
Received: from celestia ([2402:1980:867:387a:70b:38f1:a1dd:9303])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87ff54fa206sm2380979b3a.0.2026.09.26.14.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 14:07:21 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/damon/tests/core-kunit: add test for unconditionally skipping the last region
Date: Sun, 27 Sep 2026 05:07:09 +0800
Message-ID: <20260926210737.8837-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925090239.47821-1-sj@kernel.org>
References: <20260925090239.47821-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 25 Sep 2026 02:02:38 -0700 SJ Park <sj@kernel.org> wrote:

> On Fri, 25 Sep 2026 12:53:35 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > Commit 50585192bc2e ("mm/damon/schemes: skip already charged targets and
> > regions") introduced a minor issue that causes the last region to be
> > skipped before it is processed.
> > 
> > Example:
> > 
> >     1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
> >     2. Quota is configured to process only 100 bytes per window.
> >     3. Window 1: Processes R1 (0-100).  Quota is full.  charge_{target,
> >        addr}_from is saved at (Target, 100).
> >     4. Window 2: The loop reaches R2.  Because R2 is
> >        damon_last_region(t), the old code unconditionally returns true,
> >        skipping R2 entirely and resetting the charge_{target,addr}_from.
> > 
> >     Result: R2 is permanently skipped even though it has never been
> >     processed.
> > 
> > Add a test to prevent this regression in the future.
> 
> The bug is fixed by commit b3723b596b54 ("mm/damon/core: fix unconditionally
> skip last region"), which is merged into the mainline for 7.3-rc5.  Could you
> update the commit message to mention the fix, rather than the original bug?
> The fix commit already has a quite good description of the bug, so I don't
> think we need to duplicate it here.
> 
> Other than that, looks good to me.

Okay, I will change the commit message in the next revision.

    Commit b3723b596b54 ("mm/damon/core: fix unconditionally skip last
    region") fixed a minor bug.

    Add a KUnit test case to cover this behavior and prevent regressions
    in the future.

[...]

Best regards,
Rui Yan
