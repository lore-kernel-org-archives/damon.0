Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE66C72627
	for <damon@lists.linux.dev>; Wed, 15 Apr 2026 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278783; cv=none; b=TGqxvNueLPBHQ8NFFSu6qC8uJSHgt3Yag7Qw/hsZbwKbdx3kVIPtyDJ8He15SsRn0prd9Ljv3CHxMbodCnE3gPkzgJnOe8XNeFk/8UsfJamZ46sCgQVESek8W6a6nf5qYUpr8+mircKbhAPS6ZRgTDIDgI/LcFfe/DnXkUjRYdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278783; c=relaxed/simple;
	bh=0ICCdNMRNJMm1XM6bUxV2krR3fDTDUKHj9GwuT9M9Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfmqH8MqCgtJ0NWEd8kbeBcoJnktMIJYgKu3wNsgU0BvLGZdlQDt7MqBQabjsBJHTq/j+GBrzZ5UNKIcphccKBbsXMArew2ctBiXNwCDw+KdwLRHQRcbSF+iWG7gTAnzPr5gFUYToq5R/erVJGelfQKAs13E3J2AYDlDiYPPnsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDnMS5lO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDnMS5lO"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b23fcf90b2so67713185ad.3
        for <damon@lists.linux.dev>; Wed, 15 Apr 2026 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278782; x=1776883582; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTUX2lP8ldkGAZ7wG7bThpxi+xK5iNQ9DFcH7xMd/Is=;
        b=XDnMS5lODKbd/xvMA/ILh9ZBjjB0EYGeb2nw4zR3Iq+06Ih0HMyYvbPWJ27p2MIAYx
         gs4IevhnZx0B346R7vKT1pw5mBGw/VFkLXJFAuquIeI5YcNmrGYentygLx7pvcGv7Fu0
         2A/gI0YMd25A3Ld4S+wT6cP5jUK7A6T1lhgcB93oq37RTaFGQChFZTYsLFsI9JjFgZfH
         WjoPRFp+n6VYVwVxiJrD02EpOGzilMPWorgv9wix6XCjVJfGfQ7Sz3y+6CFhWqRA2LbK
         NN51n4aF0uDw1HddwFblKLpOEQ5WgKGx/URR1KELzTbETfpDf24d7tmf/j2Ykekl4hKW
         1Wzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278782; x=1776883582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nTUX2lP8ldkGAZ7wG7bThpxi+xK5iNQ9DFcH7xMd/Is=;
        b=WW1zMLIdB7k6xOl7QDN/EBhCOe5YOHkWVZgovKrX62NxEf1wEyrCBROo0OQi9FTOY4
         ubrPetLMw7pT43vaoHlBD6euOWAW58iMWGNlkD1MeYwq87G4xaYYJPEUs7DIsfVVJv4z
         WffdLMUoqfQG3JFmu9+I18JetxFb/NUnfyHpeU79/Y3G4mzvShveI8Xep67BAld19YuT
         0FiCxPYzKvWm3RGgnezR/jWlAhMEFA2np7X6AkmSXK+SPo46qb2z/zkpn4Uqy74uYJyg
         vMCgafLwHjRTmGCmOPKT3AkeviOO6Fd2MMJb0JWI88G1RLtvtDyU8g3BmHeG1zXIgj+b
         YEzw==
X-Forwarded-Encrypted: i=1; AFNElJ/iOHP7y6Iove1mN7HYpVGzxe5LkA6OPfkhnc7QuX94JCFH5ZzM1Xtedd/PCKplPeYCYxmnOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YweQFDxNr9s4CYYQ7uObJ6fNuBElObriCaSRBExNlvr8oBAAakM
	z62PkX3aS6/Ft6LiMyohbw2MaMaCO2mgXIflT5kz0LPzKnAJ8daUy/WD
X-Gm-Gg: AeBDietzKniekCfoWTLN3lzyfAEmbKxVLMYPnS5Y+I09bHiAwI9qg0l5bXDiuFij0Tm
	vwGQMtq6zfuiu3wB/CkOGk7CtSB2CuBPV6nSNQeLqKaR889FnOpnDNq/CDSseoWxog10UVQMEsi
	sl029u58KTc2+sFCqnvwDMBTh4AkOJZ2XtocX6G6DMtWAKnxlvudOoH2gMj9x5uL3kdBL4TVC5I
	8YBXrv8XpZu0i0Jd1JgXoMtwjhYwFuxpH+8LoL34/syM/OsiGMmBy1xCiXhc7XPoGhsJubArZNN
	X/6FcsTjG87Mt0qTPPA487TQUYhDnjfhEMLkit3GihgbqJsuTwJNL+I03g8OuZ0zm3CLVfTrCcV
	+xWenraOrobp8W6DK8YfsYqkIkBAuO6RlrnCml4i12dGQFauike8qT3/AQEamtbcsf5t4l66GrK
	nPsxLR1UOpRBL3dgXIFLaFAWs64FDxPSzIr0Z4+/ebMQkbR6iP68A=
X-Received: by 2002:a17:902:d581:b0:2b2:4cd2:e162 with SMTP id d9443c01a7336-2b2d5a4a3e1mr242397235ad.34.1776278782139;
        Wed, 15 Apr 2026 11:46:22 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782b6fd8sm40227985ad.73.2026.04.15.11.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:46:21 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH v4 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Thu, 16 Apr 2026 02:46:29 +0800
Message-ID: <20260415184629.14435-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003904.83824-1-sj@kernel.org>
References: <20260414003904.83824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 13 Apr 2026 17:39:03 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Tue, 14 Apr 2026 02:48:45 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > [...]
> 
> To my understanding, you will make series B merged before this one, right?  If
> that's the case, you may not need to add this description at all.  Rather, you
> may better to clarify this is only a minor user experience improvement.

Yes, I will make series B merged before ths one.

> [...]

Best regards,
Rui Yan
