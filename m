Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F3922A4E1
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781974261; cv=none; b=XCmouOuDg9zvImo9MKPuxSsTrFwVSAF8KUdMa3Vqzh3/TlB+FF174fkqt0Yr79ssi9FfG0bUs9o+3A9cOzSMhrECdtjeZ/7vFwyYxlC4skhYj3lSKTYt71SdeS1Um6JbiawGtlJqaTgO7EThz0qv/UAhHl5ZMv2IZqCVUOYZUxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781974261; c=relaxed/simple;
	bh=rCvRzKVqqyBHD4TplEtywct58eOLSdQAqV2BMQHPWxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SisSLThoiUr5E+82h+9T/kDXrfuNBuukxEB9p1meISzFmxDodK+wuvLdaFrykU5/B5hGSuhaUs3FQaIpi/arWhLHeM4wMbOxO7fCcGAcDtFT6seeTlmwu9mEVzBtyHQ1XojGw9oPAKA/KaSKVCqV73dUMoMBEAryWqKf/lhFf1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pW1k/5cz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pW1k/5cz"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ef29c5561so1735567f8f.0
        for <damon@lists.linux.dev>; Sat, 20 Jun 2026 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781974258; x=1782579058; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCvRzKVqqyBHD4TplEtywct58eOLSdQAqV2BMQHPWxE=;
        b=pW1k/5czBynaITpFIxb8cHNUJzWywQ7HBZk1HoGkP4blqT3hm3b++Te3FF4CCwJQj2
         bPUb54ExTCZXJtNnLdq/+xZY9RYX+XGqV2E7jBKARjLUrtNn4jMDf7h56dacMDwanSFH
         DQlziU/EdEXZFAK4hDrErVS+uM2PTqYWCmiB6NSIAjSpzDWVGWlJttRiEQ/GzhE64xdh
         uXu6Csdqen3OCfuVtkbjKWVqdCxegE26RUKenAMegVpmEb65V11bL+NrrEmEsCStRr84
         r1xA+TCPqGVkAkiDtprqu14+0L4L+EIgps8gpveYOcs3trEOHanlcfYpYdosCAjIIxBl
         17nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781974258; x=1782579058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rCvRzKVqqyBHD4TplEtywct58eOLSdQAqV2BMQHPWxE=;
        b=XEB/5lbxQx06q/HL5ALs2rPDNRN0qnGQHVXIJ4O/pWGQc7vcWqB5VD9T/arPVMkMVP
         7vkMiUh4HnkBIwgy94aq7yCyDKx+dqy8LFXa5KMonRQIa7OcCjXCWyGi43JyW6BvuYl0
         BVkPQuxjuLz/xSmrty7zkXhllonOVD15FRI4g2K3j0UJieXnYvZ4sYJtKb3ARXAyoKat
         kknm1Wp99WghJJ724RfY7YHMnVZo9gF6lz3Vp9Nni3+xabLyu9MnJYNUgWIGRCXNRDqJ
         qOgAY+LvQQPc9S9M/ab98eVQfgjMTmrEHxz3aQb3PRmEWkWv7D/v+AbYT4e30JdmZs2M
         vV1A==
X-Gm-Message-State: AOJu0Yz5n7wCqm3eSCol6tYcUKGUTgRaOrK0AoyvG6bz1mCGHQs7DdlT
	sLBxjiLNJecaNnUNd/no+Jeusw8CtRNJTT0xkKYg6U/Duu1zfqb8bHwq
X-Gm-Gg: AfdE7ckvcy3DZCpOc20XF0QHLMr4Xg4G2KCvObV1nmHC/zVgLieuwRmg/OUMhPeJ1oQ
	FvqHwMNKhaaFpkiu48x2aQ2xSLmKcjB3OjYuv6ADeuYDeq7+C3hXgtxtH5SM4eX+9vTUbxmC8jb
	3ucqA+wdaZEQfzy6QnKX1KKPFJrSKojIbZaWbx4T1Gui4ILnsxmwz8Dn7DKmWYjiK325W8DgqjX
	kPekppH+MwNb6aWpD4DTvxa3/+QozIZ+G7HNpsBZp8AtKzFGc2Y3uwYOLaALpt0JrwVRXq29l9B
	TFWVIzzmcfLqJ/F1TXeZoHM3hjjTN6keGnkO7Lxs61xbP7g6PTcFgoTJ+htJ0XtnjUlCFDg7JuR
	hjfqEJHi0MrT3dHYQxNib+RupqEY82CKNWtUysYck0E9JTWCiLUAaqBas+nH9+OS/yCHjMr/qwP
	GLglmUQlRPBOs=
X-Received: by 2002:a05:6000:386:b0:465:c3a4:a70 with SMTP id ffacd0b85a97d-465c3b35459mr9467451f8f.30.1781974257976;
        Sat, 20 Jun 2026 09:50:57 -0700 (PDT)
Received: from user ([104.28.165.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f4d9csm9378273f8f.4.2026.06.20.09.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 09:50:57 -0700 (PDT)
From: yahia <yahia.a.abdrabou@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/damon/reclaim: fix potential memory leak
Date: Sat, 20 Jun 2026 19:50:55 +0300
Message-ID: <20260620165055.7247-1-yahia.a.abdrabou@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620164004.86461-1-sj@kernel.org>
References: <20260620164004.86461-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

Regarding you question in v1, This patch
addresses a potential memory leak in the
out path, ctx is never destroyed during exit
thus creating a potential memory leak.

Best regards,
Yahia
