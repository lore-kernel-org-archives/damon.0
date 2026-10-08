Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7D8495020
	for <damon@lists.linux.dev>; Thu,  8 Oct 2026 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791467069; cv=none; b=KATPm3A6vi3asNYXx2DpV4I/2odsVustmWt7ZuFLTVVHn7f0DxUfr/DEge54+ugfUyynEAE7GfOgG0+KrBIUQNgAiPB4ASo7qY4521+eKMrr0oz44BUrBsiRRf3pky23BtCloyHiRTahAUF/1g/kXzIdRtmiZtGiyYhqrbySonE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791467069; c=relaxed/simple;
	bh=ZFE0RlQv7Zaby5u+QuDVSj3LjnG/H84PTIa35IOzlBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJI7+7/BybdElbi3KSq63VNOnOhOhv/bmMgtgivIaf8637p/HlKgm+Ig1vwuJnKbRBaYalbmJxlev1slLGtHdChrk6A8iCL1U22Cy01Dt4IkErieSdpifEDaYKBLVAWOtET2IuFSW5XDs/cggiQBbDyqD5rVVOtoBAwOQiAPXr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJkk1qhC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJkk1qhC"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e4a341d177so30220555ad.0
        for <damon@lists.linux.dev>; Thu, 08 Oct 2026 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791467067; x=1792071867; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M4rMUcFNA7Kug8b24L/ljfYv2etiGrFoCHCGWctjsHo=;
        b=NJkk1qhCgFNlZN9LjyMsz41roV+YXApe9VBUeeIHfYI1suSuLZ3Hn/dceLrg/z054s
         +JrJ8SN/zoGqSivwt1K9t5DLV82jJm0QO/qKxlvmqoNwGNJRBAHgO2qKHzoeqdck/skJ
         hC88+aCK/yJZVtRQJ0/ObaDmYHL8ITaURzIrC50qZUkzjnp/stBCuzbOaeooAypCOpZ0
         b/EQydKnP7n2aEqjajGvO/1M59kc3KCjopUFoRh9oolFUAz6z1y6C4Y202Gb7Ohy12nf
         oTWzrz/FBxmGE/3JKRsMFH5b4COTSC8R6Qb8w6UOi7Am+iD87ZiTWxvIm8252rlI2C9U
         uQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791467067; x=1792071867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M4rMUcFNA7Kug8b24L/ljfYv2etiGrFoCHCGWctjsHo=;
        b=QWW5DEJWFETCtm9OQwgwlVnxeqhFHCp22RThBSIMAVkFTArx/Q2V38PZGp+8iCL17v
         nfQdTMBE+ngW7l5WMOC70nf6pVgOARucLFgcu//l8MLlg8lLUul+4vxt4OkA1RVqsCPa
         kKPv/vIEUe3eBdYhP7vDrzBJDJNYwAEdW0Ez8lSCVLCHrcygrrvgERsbMOjbUicdByYc
         HPQWic2iqoisV45ITkrAGEq/5QgnrhTj4bN3J95Poo4tlbQ6WhNri1fgFv+M+B+IzWK+
         kf198VsECMcx2gcqpwqcGxiGcMSGr+AJ4RKIBHgrta+A8Sn9KXP6J6AtmIvrYYPfl1C3
         WNIQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9+sB2+EKOMFAa6YaGGvTL+8TLVT3Q5zUEMxsTGK3t96gSRI1dJplFBfyH8CxXWYPAvkjs5g==@lists.linux.dev
X-Gm-Message-State: AFq9FYIQ3qVtUWw0mxG7D/xHS2yrBsrSdcL72LLHVB0i2b8DzFyVuWmS
	ScTT0xa8EE+75+dx77SMvQKoBScFv9F+YrohGcX5LIghWMYJqc/WtLheErMae3Ti
X-Gm-Gg: AYBFou0taCVE6ChaA1WBk1BvroUm4pJNegM33TJ5ZRPX1fveWdQz9omV+t/7GfKnEw0
	cShZNXWVp2AevaevyLX+zgovTlHsgbLslsG6tRbNtFdm8H3Ulx5HezRqmlh5m2aywwc6U6UOKFZ
	Tc2FcODAcH6J13tEG46TTZVMcZa5oOGlEAEFXboDdmNN2FHiKVuCiaEY6BetMLtAVTdCpsEbUE9
	Izg+zWc+5HbyWszPtub6xV9i8QIP0p2YQvciJFltZhrXloEkEvIgi75v9uiZA371JK83rFPBDgq
	BEH6tSV8LRb6Dhj4WOs0WXYvMzSNOcJAM2xE+ERYwcZBf3mjPSwLHt5/MJYM+4xdHdCzdmbzkJp
	8GgAxR9jFikq4AQKmdHVUR20iZlLNsB3bHn9fAwyFOKtWlPYSCO50Nb62c5NUuOXi9ryRk9jOR2
	PtPdQ/+ucgAeAKSfgyKkbGQALm3Nd52SQQzR/PxLSqGGji/q7ZlLvY48ckiKbeqWzJoAIl+Wkir
	IMbUt3VVQTEJdcezVQALaYUog==
X-Received: by 2002:a17:903:1a6f:b0:2dd:ad74:ac2c with SMTP id d9443c01a7336-2e6004e3b3amr50094555ad.30.1791467066545;
        Thu, 08 Oct 2026 06:44:26 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2001:d08:1334:29ed:db11:2c4c:ee4f:606])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e604720215sm25363195ad.34.2026.10.08.06.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 06:44:26 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC] mm/damon/damo: saving damon sysfs configuration
Date: Thu,  8 Oct 2026 21:44:19 +0800
Message-ID: <20261008134442.31243-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008123231.45171-1-sj@kernel.org>
References: <20261008123231.45171-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 08 Oct 2026 05:32:31 -0700 SJ Park <sj@kernel.org> wrote:

> Hi Liew,
> 
> On Thu,  8 Oct 2026 20:09:05 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > Hi SJ,
> > 
> > Just a reminder, I think you might have missed the question I asked.
> 
> Could you please clarify what is the question that is not yet answered?

It seems I forgot to ask the question, my apologies.

I would like to ask: after reviewing the reproduction, do you still
think this is a real issue?  If so, I will start working on a fix.

[...]

Best regards,
Rui Yan
