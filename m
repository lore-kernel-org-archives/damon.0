Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A433EFD09
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545347; cv=none; b=lxmlI3wMTUc/DKGKqkClIphXYMzxNRVBJdkbQm2b0UdfYeBiyxbusS+ubF8ATbHgPmqiu9iZHX6Lc6m3lPaa7418XgCS/yBGIliUT8Gb/Ls7oCYwuYB4TUCN23GrYHHVr9S6dnYYzik9LhlKa8aK2K4zb0EzJWA0j4Ix+ROfE2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545347; c=relaxed/simple;
	bh=JIonyDIPuEQrFkFWzQ5SL8GEmqFXXD/z+7p3dqgRC94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWYdxGeQvSlTcpgBWrpD6rD7KDA15G7fs6EUNe/+wl1Ao2HvkgYnIvgnK8WapRqsvFtoWtXYjrT0v2hlsuSxkeztm4O9pAAFNknJOuAVbhkbH51M2U37a315p3mqQKkkRSJvhtlM3+M4JVE32HOTqWQa0pYbr3dfVgKGF/t64U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdN/wkjo; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdN/wkjo"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso6509230a12.1
        for <damon@lists.linux.dev>; Mon, 20 Jul 2026 04:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784545346; x=1785150146; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x+LqOLf1bSbbTbtCruD1zKjWdUcVSyhnCC+ieNQDkuA=;
        b=jdN/wkjoanGcjdKUO9T9AFR8byOXAwzU8RwUCufWdsJhkHyWIAcvrc2EHqLwzJOtbh
         r46CQjliAKAAyDabUBY2fjibpW+loMlpilNRAL7s+dC59H1hRqftEVG+6SbFhT1ioQcC
         cadyzpc+cCFC6Ogz8acZ/I1vsuO9zFsu28ddEvm9C4g3bbNMcwHUSRF9XjSfRHS9I716
         TMXtX3NOjGmWSLd6EbJCvwdEEwLU7tDjTS7ONkONp5R9QX94TWIuYzBuBavaVfT0vOaT
         v3R/1gPWmJxPU2fSzo8ZtP6TOBA0JDFM9FythIBDD8oMqJeRkqXvj13Q5UkBfp66pCLs
         fSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784545346; x=1785150146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x+LqOLf1bSbbTbtCruD1zKjWdUcVSyhnCC+ieNQDkuA=;
        b=hkWtWAc0QrhBG/9KmyTesEANc8FOr5qDt9D2/6h8kKKtz1qYAHGvXeKNEJ4RYqqAjE
         I4460xSbk55Q8DWZN81KTwRJEpNkz5qWKQthMdTuTTGW2cEDzzqTcVDw8KFxRFCzDanU
         mjp+1i7OqV1o73glJue22Krp2vbx1z+28OTLqN/if+1tWUwdbTQKfIe8KEW56EPr53IA
         tMiu9glx5LSgU7YD1p/YsSwwoESKXsWc02rSeerRsEiSI8mT0Y8QKrmRrnEv8Bh5TOVn
         Oiy7Z8f2QLdXoTSJ+FecFZtJ5uhjKFFETCefuYSH1ugaR2YX3+CgPGHeqXfhnHgAzIkf
         je7Q==
X-Forwarded-Encrypted: i=1; AHgh+RrUMUVk57t0+OiPmgIQbmdj8m12qwT7Yqh68pXlkLb/oExTROnb/9ig1rR3sKQQZ6PE+GMpSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YysQ1Ih4u1lwDaq6thRDYW5+qVHNOipH+aRmtAXgcw+6AZTdPMq
	ArcIlju4uLUmw3SNhVeo+FVr+CM7Dsc9VnN5bRpUIlQGZGr9ieFtnc/U
X-Gm-Gg: AfdE7cnPDU+dL8dUCeEtawv+ottdxl5Xapp84ZgxMVJ0W37SoP9kbeHA4c9sndjn7Ah
	fa5yihvLP6ZlVGfFfgXs92M1EyKne2daxh69FxctboUxTLe5FotliUNxbuna+oviztzyiJi4Gzh
	HzbstLlNwL/IrDm5ekzptC9uPT5tTIFN7UHQEu1/HaK7OBlN5FNifl5X892nb2srY5UAnxCfSqB
	Up9UBQBx1Ik6Pmry+qZPusoILM++J9CZ+dcgnKogScFbI55+yEP75KIwh6p45gIAgd/s53VfLVH
	a2hVV/F4d68cUtaZJaVtwIfhdO3wZ/aoxxTeQttYkLWhjAAINQ2VWI7SSclGThxUYS35HoLARsk
	dx0iA8Devg061gPtuNE/No7dAvb659vN8ORcZpdjglijtjAeSKiuwfbERI4u5F+9T7zFU4dAows
	rDQy+VTiZJykc/48AtC2SDgD2DByYEU+DI8aoxzVQ7
X-Received: by 2002:a05:6a21:478c:b0:3bf:b182:94e with SMTP id adf61e73a8af0-3c3ad66b538mr15799239637.5.1784545345587;
        Mon, 20 Jul 2026 04:02:25 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:8d9:11d7:8597:c44b:bbf0:2c09])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29c2c93sm31585842c88.3.2026.07.20.04.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 04:02:24 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: gregkh@linuxfoundation.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org,
	stable@vger.kernel.org,
	yikai@z1k.dev
Subject: Re: [PATCH] mm/damon/reclaim: fix typo in damon_reclaim_timer_fn()
Date: Mon, 20 Jul 2026 19:02:32 +0800
Message-ID: <20260720110232.312053-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026072041-rearview-unselect-3f92@gregkh>
References: <2026072041-rearview-unselect-3f92@gregkh>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

On Mon, 20 Jul 2026 11:59:03 +0200, Greg KH wrote:

> Why is this a stable-only patch?  Did something go wrong with the
> backport of this commit that is not in the upstream version?

Sorry for the confusion!

This is a stable-only patch because this specific function was removed
in mainline starting from v6.2.

Therefore, this bug only affects v6.1.176 and v6.1.177 stable branches.
Mainline does not have this function anymore.

    $ git tag --contains 2f54908fae21
    v6.1.176
    v6.1.177

Let me know if you want me to resend with this explanation
explicitly noted in the commit message.

Best regards,
Rui Yan
