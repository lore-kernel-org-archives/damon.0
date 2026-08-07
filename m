Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F802E736F
	for <damon@lists.linux.dev>; Fri,  7 Aug 2026 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119534; cv=none; b=HAmEynyyODkk//kRfjz43ZxMUjqKyOn4HDP8g442qY5HA2jhd0pVN3iKzE5rr0NYGkLDhVma6t1InZepW2rlruqKOv7kYyjR1ip05Dq8Vvkm285kcn0VhhoXEAGQh0Gf3MeiG3uPKhXTJVyM0ddLwJorCfrmzZpFLH0F//cswRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119534; c=relaxed/simple;
	bh=2wrJp6qlSR8AGz/6Y7Jcu2jYTBVf43EJdC07h5bjnnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiT3gLjk6mtFru9cxKy9ySDQ6uSCTmYnrTc1WVMHOEWp2sgGhmqpSu303ZPeqd+9WUeiCIZte8+W3KxWJOlZzSHkORzjkXyZKQto7+2Iy9lg7bKhrwLVeG5f5s0rkfBnOh7zO6u11XkScyShK8CqKKiWOguVRE6C7ONrHoP/GY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jh7NFLDb; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jh7NFLDb"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38deea72eebso3107204a91.1
        for <damon@lists.linux.dev>; Fri, 07 Aug 2026 09:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786119532; x=1786724332; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xPAASAJMLr9J3CqKbh9dNVdhMzyGvdXIIGCu3+XVZNA=;
        b=jh7NFLDbcrGLezldEoTHrTlwKvpCHialzEEGpDw72Yfh9Q0bWMmSIZ5Uae9jZl/QHk
         nkysn0n5TXsZD+pcSDQ99AmArhlAZGaBGyy/2PNUgJlIyM/gwGk3QXM1ErzoN5vhxu1P
         rA7TkSVJnj5Nen9elVDZPpcUEn/nPz/3RrZdwofXjlkKoL5bbg4fdgwNkujtqSw3G8Hd
         Ixr5blfaiTiHKI7pHUJxJsk30QUHNyAly/NfNT8Iyssikx0TVEXNGcVxRrSVb7Aw2ynj
         BmRhqpEcQQ30q7rHgBEG+RShLpvfH4zspYO3dUI+US7vFcjO0H6dy3E73kuYC1CfwFKT
         yVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786119532; x=1786724332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xPAASAJMLr9J3CqKbh9dNVdhMzyGvdXIIGCu3+XVZNA=;
        b=Qly7QEFiy8xl6Sln75Gk13Gtx8XLJMviEtn8MEn0FtmzNswME0YxSXTalqRWTVA+5f
         Mq3+HOpKd6FaLj32xMeRm8MBhY425+jCAtQUYtobk2ir8duWMjI5tJTWBKLMk5TGutLY
         r1E6jg9dvwsN/CcFk3y581adCopcbkFc5kZVVLva2ZyprxC7ySay91Hamt9V7ZmI83Ck
         HTOdTI+SNkQsnhrTiD/oZd7Y2pPjCd1DfSZzlhxoX0mNyCDhoYIctwFtrrN5O9Y/VcE1
         /6qgivlIUXZ/B81PPKQhMzqPuTz2GDMUkNEgdkQBmtgPhhuwi5lkRwAoB47XOKFLQszO
         GyHg==
X-Forwarded-Encrypted: i=1; AHgh+RroFG8So54IFo7x3qknfPaCnF4Bb2oWMJlcUuvXBZRCaYyUmmwELBED8absLaDj9L8KmnMhvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZWNrTYm8mN/lU01RkAZtTlzLkBGuLRxADn8t/bkUTbGv+5MCv
	QqU1qSBLev+Z+Eb2NGrBdC0Lkdj5zdwlyFjittNPZVUQO7pWDsdZnNdt
X-Gm-Gg: AR+sD11A/bsyjEhswGAi5bBR3VdTw6y30caIhWEIadwYafLYVUVsQ7HvFDNW67AktzO
	gGM2sttTjEySQ+MfKPh9lNRDMb3lz85ufWRCE2tyh2jnthYJ1rrtGtgNN9g6CXDdbgR9UGjXGem
	KFjPYPfObZlkxWzp5/tujnKfl4ympZPTI3xSUXZ9fWIZUPRDtCN3dInvNAIuK0UUwoo/xO9RURm
	hOLZQ6NJ+9aDZKRlXKYEgOVcvIB5mf65b8q30rGDq5/04Med02G+e8s+qLzCgMqL4Tm07Zt/tk2
	67P6VEER9l7SIU1qn5plPiZFQMRqi4wEF+9R5p8WHGMDZDE2n4pigog/+9qDUec+237bUO/GtTn
	5JqlOfcWwqUdIWJHi0nXiXbe3D0TKktEWPp8Rmccuxw8p2WGowok5YUeMW1j0/96aU9VtV1S7Kl
	WBzeK5yi/nWaM7zKikX3X2TnI2EFMoYyyaxmPT34EwT1TmaG7m6kUlfqqho66SbTOhOPB4vpaQG
	KK89tidrCLdl9wLSw==
X-Received: by 2002:a17:90b:4c84:b0:381:c500:b0d1 with SMTP id 98e67ed59e1d1-39282554a40mr767321a91.20.1786119531993;
        Fri, 07 Aug 2026 09:18:51 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:935:f4a7:6f5c:e816:9aba:2090])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39086164982sm5488522a91.16.2026.08.07.09.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:18:51 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/2] mm/damon: fix nr_snapshots semantics and max_nr_snapshots check coverage
Date: Sat,  8 Aug 2026 00:19:00 +0800
Message-ID: <20260807161900.57054-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807141214.91390-1-sj@kernel.org>
References: <20260807141214.91390-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

On Fri,  7 Aug 2026 07:12:13 -0700 SJ Park <sj@kernel.org> wrote:

> Thank you for sharing this patch series.  However, I don't think the patches
> are fixing real problems.  Rather, it seems the poor documentation has confused
> you.  Sorry for writing the documentation in the confusing way.  I commented to
> each patch for details.  If you want, please feel free to send documentation
> update patches.  I will also try to find a time to do that if nobody does.

I will update those documentations! Thank you again for your detailed
explanations.
