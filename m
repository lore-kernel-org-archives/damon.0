Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DEE51AEEC
	for <damon@lists.linux.dev>; Fri, 18 Sep 2026 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751249; cv=none; b=khuxSCaooUMqMFYhf725ctQsosRR21UxAKuXjABRsSZJ0cWMRy8vaSdZD+F/zFKSV4nSk+eKv+zjk7FY6MdZjGbr43a1PDYGbsawHnHPSlmcZpVGk/4V3HzHNx665c37pfpTzWrlB+8XTTWKcwHR2Kn9AUq74RHk0XB7cvks7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751249; c=relaxed/simple;
	bh=PVQkb8h/HFIIvBjGE5JjDQ6o5No3SfXCNcrCIUgaTp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z178qxorgrvG1xGuc1LrxpQRfEh68rr/V8/yQz4eJtS1BKl+sLZh420iO1WlLHmzdI9WoFhEupvf4boRIfQL35JfmZaZJnbhU7hPpaPQpLgjs6HfxjYH8V3qUTYNXxD8LUUpTsdxKEV9Uzk6mHxMUe8A859nFeVka/NMvBvCprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnyyhqGB; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnyyhqGB"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so837151a12.0
        for <damon@lists.linux.dev>; Fri, 18 Sep 2026 10:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789751248; x=1790356048; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PVQkb8h/HFIIvBjGE5JjDQ6o5No3SfXCNcrCIUgaTp4=;
        b=KnyyhqGBrQPMLcAGwxF73/QYZwn4xNW23PvZ0n0yoSVnkb0b0vuY7zPbcW3NyO+i3X
         Z2CFlNZ+8aE/dajn6LPdRm0UXWQUCeM4FT7EtGWQOhBS7+qyNnv1Yo33csn4MEZeHKD6
         GPBN9mlOQdLpisgBhG4GDbB9hHFAqGVSQZ+eLL6FNGRubrFResO9MXg1Xm7zlmMgAFPi
         EdXDxLnOmhEfbQJ6YeJJeD46E+dyyY5wih+LihBzoFajJpj6els6YofhCpuJrgDxQOmn
         5TFp83OMgruXh/2RHd5bGRYJ0BHq2LXeo1noYtCt8uc2FR6xpmpmYm+1cXklveeE6Hvg
         pFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789751248; x=1790356048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PVQkb8h/HFIIvBjGE5JjDQ6o5No3SfXCNcrCIUgaTp4=;
        b=TZK2ppUhXifd4ON+Fj4RySdcuwKkYPd4gx3+axfmJshJJo07OYNooALlt914nAElYU
         d2vMYl1mOfvQiK/lwgbjHi1H1Awu7L7JeqzwLJkBAaC8jarxHYLnemgMK7z1SaQnVAmE
         C/uv1KYjaEiNVaC5naSDyBCnLnNYjOILz9GPFf1AFeMpUy6asGwFU087MeIPNJJRmvIg
         Eb9xh51Xotb2Eo2l3HBFI5LqAwwo4/DEQYkUO9qX78/BczDvmJAIePAPcEX46tXAHrB6
         P2sQN3pt5lmWNqNiX5pTG4Jf748SyCqQ2B0k9ukLF7g+SYmaoi1Xd+yDu1vBzpeKqXjl
         m9iQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxbjwcdfFLzsuK37p04LLJvd2p9JgwSFODmyfb/ajmhDbHX67bI9XXns8x7KRdpUrK9bVSDA==@lists.linux.dev
X-Gm-Message-State: AFuF++l2o3QOL14PbaKQG08Vkfx6OP0cxkv3Q77/zIX1qJDuXpLkkRbN
	yZ9qRewv1MFheRyF1SRpYIEQ7tQU4fvkbh/loUwUJFt8kCi42TgA0BWgzNNT+9ZA
X-Gm-Gg: AYBFou2JxG0OAYi0tvaiIArEKuqIiP2mk4MN7ldc2uJjQalE++wrlouRm3+FJY/CaGZ
	tMlKAizon0YmqdF6sI9E1cOf0o2qA1/3gT3AsRkXdRS88fmfv//vpX2vtjoJahfCahcYHNJIRou
	DVr2PR4AtxNEoJaBFRq7XyDWxpgR8zlJdiv/eAe1vUToOMSB2TmkULvwuxf2tageUgC4brtfWey
	MV7gGHULNs97o+rt5dya6V3EVyFeC3nBTt8e/8mjVlieLI80jf0OE0KmNyg8TCVWeHmBgmMnisK
	dXiYuYehqowp/uQewAZXm5U/1IeriVW2cIUkGaTqSFR9j2fn8crxBMX44ZFygYXYtMtPUc85Lnd
	CnKaEwS1xoLVz8IZt3dyjdiHfwFvYhA/F80jQqkfgRqVd09YBKv90l8nDfj3vdrvCC1LKdQDGEO
	31+Hb5Oc+ztm7dYQnIa9l26mb9DERyoDReTWUQ+ABZ/0K3Wx81z7ah91VBE39dbAXAH5gWeSmwN
	vMBJ/G0eiP/ypmAcple2KkY11bFqS+NmdcA0QDIgeeBR+1HnFY8Xycn5RzfNyMGcF0PncZje0V+
	ScJdTb42s63neGrLEmeduuT9ELvxCM2HPwxW/NywzF9o
X-Received: by 2002:a17:90b:39ae:b0:39e:6c69:34d2 with SMTP id 98e67ed59e1d1-39e6c693659mr358962a91.54.1789751247561;
        Fri, 18 Sep 2026 10:07:27 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.202.182])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55e29absm116665c88.12.2026.09.18.10.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 10:07:27 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon: document that a zero sample_interval is accepted
Date: Fri, 18 Sep 2026 17:07:20 +0000
Message-ID: <20260918170720.105849-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918133513.26828-1-sj@kernel.org>
References: <20260918133513.26828-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ, hi Sang-Heon,

Thanks -- appreciate the review, and the pointer to the July thread.
Will post as a new thread with a link to the previous
version next time.

Thanks,
Karthikeyan KS
