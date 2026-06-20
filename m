Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648E724677B
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781976042; cv=none; b=PwXXGfsSzKU1Gk20JJhRbWPgTy8sy+SrvkM4zK+Pcnq3p3/cSG/kuNoK11xwxfPr3q9WZqm+ZDvgpcjZraOMgr0J9oOxICuUyE4IALGXFrIFchJhRNK7n37FwvCYJVOBmgIUMEQM05l7nORZWCCK7sEHel4zBoU1eeShxQu1GdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781976042; c=relaxed/simple;
	bh=2TdgMWRr2s45zf2CRds4OwO6qMuavpApSwfTh/s1olI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCqPjbL0Zvd1ADuy5Q6FzYPiZJPiCjupL+aaVbGxndYC6FcgtaP0j7KFM/alOc8IGPXY6NMhuj5gsFgT7STV6NBp5c9GMX7tyNXx7huucRwGehWO4FZdD2kJHbz84V/YH95T4y4VZVMyMMLLRemVp+13xZ0a+hJ1HZMUOQfwjBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ij7Btq4P; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij7Btq4P"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so18181975e9.1
        for <damon@lists.linux.dev>; Sat, 20 Jun 2026 10:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781976040; x=1782580840; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TdgMWRr2s45zf2CRds4OwO6qMuavpApSwfTh/s1olI=;
        b=ij7Btq4PVWKISngZcjHPPEZHTl+kiZ/cy5sad1M0KGEzfXp3JfbbldUIaxUCOmWUr3
         enp+uCvPhXhYhSZ+r2n0AGSrj4Xtcx5ZV50Q/pcpoVkgnNETh3EjwMUeFdwBOI1aIyB9
         XZ9Pjkn1JchpNH+cJEeluU70XJhaiiz7L7HbA7lsRUr+ljOocWVOEUix2D91Z8H2yfKT
         Hq01M6PjbOIrd5QdriFDt6VfwQHx2srfvaPLSCClGY7+h9z1DtXHJxjOhK70lF0mAo+U
         yAIVvmYEbJwC9JE9sBf0bf1MZg8xSTDn5K57hvvj59EldFBpO+D3QK8b7xGlnwlV0xCQ
         6vVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781976040; x=1782580840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2TdgMWRr2s45zf2CRds4OwO6qMuavpApSwfTh/s1olI=;
        b=Sg3Y5nmnbaIHboLCC878QMtVL4WrC1Eoaju2SacdsFra2D6JXMCGh3Me1TmjzKo8v/
         oyGW0FGQwaQNCuWnPRdxDggN0xhIS84ArZL9+ZAkSJeuptZQO+waxFM8o+I2HiPLj1J0
         nJ+ZZ6A1QNOS8eOWuHeBxBEAJgoucbgaQcSLKskokIJK3fV++XjUUlR6DEWG/V74SH8I
         X0DCuVTWTNLOuaW9mYBM7SA26drwbHgc+XpbfMNiRCopts9S57nQ/b1ZQ8lQ2w29p1y3
         Y2J8XtXmv+B8jdneJB8W2nao7ayEmb7JiSxT2Y46WJibAXzZoTtB/ZFdPCFfLXhigY0h
         EdiQ==
X-Gm-Message-State: AOJu0Yz4EEJ/0ZxfWpMHKzk98HVVDCrx0JtAcIFWmmq7fvwmo84RTLHH
	JIPcAlXM5L29kzM10L/uXwWR5em4Pvjo+wY7tqNNYZBCV8lH49V5m4mS
X-Gm-Gg: AfdE7cmzCG4DjygbPdvPsvmczYOiKtgUTxfZ5miLbnWWpJpOZRPRgWDhHNGTsYVtAvp
	kHO6UyXZw+YocYxWkDCMrsX9mipwA1iVdQwf0zjNNmIEUhTFA5GNIKLi/g6ForoFmPJWYqg2GOz
	WhXd05HBlNcsWxYMLhFW2HrazEq80q9qD0e+YLkO+lswiTflnjuZK+nY2xCtZ7gda8RuvEbul/s
	ekvCpfnyZXbi2PzdJEk03wCSX4Far/FAMKDQuzxWKWdmWZ0hlYo4TGJfXkLAEgAuc/mdUSZhL3e
	az/Ej376WQ1IJAW0UdGDF7RfyvAtmiF3hsylZmronvSfS5mGGBzkHyPzfDPF5XJtVmKcUUS9sNf
	3JMzyfPPIl1ojiEASmZRALuRpr0W3H0htyMpLorrlZ6DgRQtcUEq55p9qxcLURAyIvWNWSJ1guV
	gAFx8Mv/BDfIE=
X-Received: by 2002:a05:600c:3b01:b0:492:4911:8a with SMTP id 5b1f17b1804b1-49249110250mr54012005e9.12.1781976039950;
        Sat, 20 Jun 2026 10:20:39 -0700 (PDT)
Received: from user ([104.28.162.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249238bfbsm83974275e9.5.2026.06.20.10.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 10:20:39 -0700 (PDT)
From: yahia <yahia.a.abdrabou@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/damon/reclaim: fix potential memory leak
Date: Sat, 20 Jun 2026 20:20:37 +0300
Message-ID: <20260620172037.13894-1-yahia.a.abdrabou@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620170935.89236-1-sj@kernel.org>
References: <20260620170935.89236-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

Thank you for your clarification
on the design intentions.

Best regards,
Yahia
