Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A74F2BF3F3
	for <damon@lists.linux.dev>; Sat,  4 Apr 2026 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775293883; cv=none; b=X2kQBsEw2BAB5mRl+45wqA30IEOKohMt0Imzg3+IOwtrnNDm+sX+XWvq8vsV/vhN20cDJbRFwq1GKzZ+Lr0pIrBetrwb2m5hoQIVXs8xPPxy2vJ0s9fHH+dyva/pfclzWDj8SXfqxh5tLFASt4FdNStu2RLL15mgzJfLrumY2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775293883; c=relaxed/simple;
	bh=tyEHdnMAnapnOelAFAFnr/ShI5H+66xQITD2M1VN8Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfEKHmYaVlVed2E7e6qenRzqIAf5XR8gLj0lsGbbhs6cb8KXIPisj/tRN1P+tRYgU6sFQOv9jzbsyWbOoFC8m5/hu+OPO1HDbw0g+zaByzWf8HoZSfqeBYR8wxN2xRZ8hWjnzEfkrKX6xlzIlbElKUzeb+KD/AgmVzJ+23kJnHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdJegjAT; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdJegjAT"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso1283245a91.0
        for <damon@lists.linux.dev>; Sat, 04 Apr 2026 02:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775293882; x=1775898682; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mKCgOtEX6fdxiOnTa/jmRynhm9AIpzYWnO4gPE67L4=;
        b=ZdJegjATCbRN3PJ8EgFVFrqtwkK5ulBlPlr/Jjn1KgONd3X8H5QfDD/VOLHb5Lhojy
         7khhK6KnP7EdcoesB77VSrElAx9XfdMLGA7nMCLxD2QYmjOzgkRVC29N+a8keGxLVOU2
         j1B5vGqTe0qCzM9aNFSDD8dOVe9wEPNyALiTXuhI1jAXoFATVpIjjD4d9UK/I+65w9Zw
         xy1xRD2riibaxPdUK54W2fEpvTSOpgzda8XwnL0NHNKndONGkpE3GC7Nb6U2O2zJfwog
         U+KbBJXebydjb/YJER4OlvXyaLeAd+ynXQMNP79VLicXp18Q5GTmF4rCq0A4YYOu4Aq5
         0pmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775293882; x=1775898682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/mKCgOtEX6fdxiOnTa/jmRynhm9AIpzYWnO4gPE67L4=;
        b=U0ueq6RsLv98K8aZ4FmCU54AmTzf2SZ3yRItGO1NvdySeETM0EYLGXyWyEyqOteJwS
         EeJarMWVBp497WiPMhDCcOhybjgBlxMJUKz0KZ1VjDLE/PMUhhrUVDromiDFBQJZs7WC
         gl2D/fZ9WJQSQOaYfyAl0Z9r9gFMmFVq+k/iQg6XSx8aHWHVj5IqDvPmjCA8IzyehdqP
         qpiSfBBb2F4nsUh6/KBTQf/9yFKzXlDT20yXzKfLYANSZZDEaYVc5DGjIdokb1f/paNb
         uWI1ptrEpmp7cUOOGWzCo14hNyqIqdtTIZTAWVm0qNvuyFff9uDTHWIw3MK2w3Rktbl+
         L57w==
X-Forwarded-Encrypted: i=1; AJvYcCVZXK5XKTuU/7vCJUFqJStUJcZpqTL2pBc1KYud3tK2m65Wh/se9dn9kb7BtyuTVJnyyXjvGg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxreaz75JXA+U3cPDlzrdvotszMuqfw9D0HcXg5gsm5sT7c5pXT
	qXFIlbFhqdYPXRXNJ+TFSmAsKKAo24VEwAi+yHtgQxLIiahjAHxpmahc
X-Gm-Gg: AeBDies/v3uWpP4nsDssKTjqXNZPc9HOI8L+V3qAnRHFaY8U8/vGnSQp7miKC43Dtk/
	DInHPDk8JuQejSpeT7lPdl6L9hVLM9O3IDCBPIwf91uEq4xDPXbNOh40oyjYatTOVrnCDbkqe89
	a/JBSRAeQlrFnv+OoBxr0E5INwWmcUQMw6DlU0J693cr9UIBY2o6vo95e/65yJotyQwPptYTT0X
	oo2sosBma+LHlABEPSMxRYRkDlbVciogfjxEhwIQQU5wDc2TcgMfnndeCLEQMxZmukVNvDRjI2I
	HdxP0YmF9zlzuO0F3rWx+jf58Hw9Fsb0gKZCJydg+rZ8Z1Bkb840zy5ANcbUFdVTCpprvovqAuZ
	ard2Y5K9ZK5DqAHhipI1H90DvUsqf42eghrUPzztxRWg/DjOsD76T9uKO3hppZpAex9t3PphfT+
	oPgSlFXEdPNJkvmRUENro00uEQGZW9VTx9bz7CW5s2WZp2RwFM6C8=
X-Received: by 2002:a17:90b:6cd:b0:35d:9560:3f09 with SMTP id 98e67ed59e1d1-35de69a5c3fmr4674889a91.24.1775293882050;
        Sat, 04 Apr 2026 02:11:22 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35e34f9sm7710233a91.1.2026.04.04.02.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 02:11:21 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Sat,  4 Apr 2026 17:11:22 +0800
Message-ID: <20260404091122.6255-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403161906.65008-1-sj@kernel.org>
References: <20260403161906.65008-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

On Fri,  3 Apr 2026 09:19:06 -0700 SeongJae Park <sj@kernel.org> wrote:

> As Quanmin also asked, clarifying the unexpected termination would be nice.

I will clarify "unexpected termination" in v4's commit message:

    "Unexpectedly" here means the kdamond terminates without the user
    requesting it (e.g., not by wrtting "N" to 'enabled').

> I remember I suggested adding stable@, but only if you think it deserve.  I'm
> now not very sure if this deserves Cc-ing stable@.  As I mentioned before,

I think this deserves Cc stable@ because:
- The issue can be triggered by accidental user misconfiguration
- It causes kdamond termination and hard to recover/restart. Once
  triggered, kdamond remains in an unusable state, and I have not found
  a way to recover/restart it through the sysfs interface without a
  system reboot.
- The fix is small and low-risk
- It improves user experience on stable kernels

But I'm open to dropping it if you think otherwise.

> there are multiple patches to review in parallel (you are also having such
> multiple patches in the queue).  Please don't expect I will follow full
> contexts especially when a single person posting multiple patches in parallel
> every day or two, and bear in mind with me.
> 
> Sorry about the limited bandwidth from my side.  You could also simply slow
> down your pace, though.

I will try to adjust my pace. I've also noticed that the quality of my
recent replies/patches hasn't been ideal, and I will try to be less
rushed in the future. Thank you for your understanding and suggestion.

> For stable@ Cc-ing patches, more clearly describing the user impact would be
> nice, and helpful for judging if it deserves that.  Could you please elaborate?

I will add a "User Impact" section in v4's commit message:

    User Impact
    ===========
    Currently, if a user commit an invalid 'addr_unit', kdamond may
    terminate abruptly. Once terminated, it cannot be easily restarted
    via sysfs, pontentially requiring a system reboot to restore DAMON
    functionality. This patch prevent such termination by validating
    parameters (addr_unit and min_region_sz) early.

Best regards,
Rui Yan
