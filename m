Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0B33F8886
	for <damon@lists.linux.dev>; Tue, 21 Jul 2026 01:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784597681; cv=none; b=tCK9Eh0xNvFpIFX0DXENH2KOlIkf62c3JsTXV3R8n0klBqj7mvjzy9ViXlE6Uw+PwCUGTo1P4LI3AmwO5tGIoeNx1TP7lULGfJL9TJvJmcl2nEKmP4Y9ywZK2pzwA3wgw3dE3K9+2Ptiop0nsQFm8DVZI/c0GCx6oh7mCUNay9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784597681; c=relaxed/simple;
	bh=mJLkB0+y/24FxCNgyMJp03dtT/BJdht1U42+/E+iqig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hpe3kT7Y7gTnFyMheO73/aw5sPtnw/j3VYEdPpiQeTa4Vn5iyUGjh8h3usxZl7spUoP45hUd+3KZn52cGbVWcT+kDJWMroepy+6EZ59hE64NiInY+rX5C8Zf2fN+nlthMVN+3df48m2zyVXdcsg8tJV9bwG35GMIcBk1PFu8k9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UusPJ5ep; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UusPJ5ep"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so116658245ad.1
        for <damon@lists.linux.dev>; Mon, 20 Jul 2026 18:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784597680; x=1785202480; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C/tCUmc6Af/w9eCR04YBcQ5lmA7aoPQojmTNJw54oAM=;
        b=UusPJ5epJNYTY7LA/QwVs47vcqry6bD7PfkW8rnjWXb4/bDWLHCQPkRAsH/La/MYg5
         6Qa3+DDJHw6LWnTfim2D2gR5KAz4KLD8vlMFe+7EQyod4YHB0cPSrjppJMZb+cpmR4Q4
         vW0j0OadYObdKq5tSWHyEoMcNtOjW9a8DOXB5Jze80tM7RTdjspmI23wlXxCWvMe6odv
         ftsezN921YqLAKlEOq4b5gKpyg6vMs7XFvHYfl+9TRD0B1fjA5JWNkyHfI3Z+0e+X+WC
         p1FJXB98TmxX+Gc6hNy2Zp8JNb7PYaq8gyOKlL6tmd5oN0APaeWfN72HzMn/kFurS6v2
         MLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784597680; x=1785202480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C/tCUmc6Af/w9eCR04YBcQ5lmA7aoPQojmTNJw54oAM=;
        b=bbYCWj2Qp8yV2autfTovrHbsOUOvCYM2942Kd1RCUzjipviKtRegeovUm+8gAAE27G
         6ziCdp+Pybe7cHf3Wz2bh88ErMUMjWfnYXTWci3Or+Vn5XE3LrgQk8Wp4deFuXbLhUzq
         FIkUHjqEY1WdlyCef5hiKB5EF+ej+B9ydx92FSqGLe1K32InNKoN7hkwXe5qAIr1zKKH
         r9mlGckLMs7zDPPftFhK+WYZh7WDU1NsSRrmX3F9qWAQpjmuEcKF2y1EXvuxNrRMyjPW
         fxrr8SpdoWEtCtZ9lVK5hixbTVcT9W7f1ctFPjNyeyPRNw0mNoyy8/vabVoVaFQWqMON
         O/lA==
X-Gm-Message-State: AOJu0YxGQ4B0Kn9ybUQmJ/yVYWRekjldQ06mtmrqc3R8jBhjEnphWLNz
	Pebwrqc45ABdWulco9rg0MyV2jeZ3rzNXnqGrOc/Bd+NgrdA6N3e4mt2
X-Gm-Gg: AR+sD11fbOdi/PawPl8ebvXNKkck6cu8XcO3PyOnreAig8deMojHRRVsb0JqMrKR0ND
	eW/QCntYqj7+sl5Fs7JpkvHpMGwV2O0BATZ7fySIKRc2RbmyhVLgihc1Toj4HL0crS045bjnHlc
	eggcVGtJSHqdJ9sKKLxc1RmnqK4EI4/kjE5IFAprAogU7doiEGmQpeF+5eKg99+V1iq3fWB+idR
	G63hMpLl2ulTJdSuiV5BzXbhduKju0CeEoO86HbqAQiUuofXycMAvpIrpnny1cksQGM21R7Yijp
	AUxF/q8Bs+1UW/2NP/eYzCkUKhBgJtfcWKizvqIJEPm7iE4K1KZ/EXbOJfVs5a0aBLgE729E9/w
	+PVATogFp0s2nZfvRA428r9SSiPQ0yKXD67sugWBZoWFfguNvq625VcKvtcpIPzWg4sE0nA+XBv
	1kUAHkU0EkGHinxp0jEm+blCDo4Ks=
X-Received: by 2002:a17:902:da85:b0:2ce:93a3:c16c with SMTP id d9443c01a7336-2cf348665f8mr180911895ad.12.1784597679975;
        Mon, 20 Jul 2026 18:34:39 -0700 (PDT)
Received: from localhost.localdomain ([112.65.87.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448f91bsm65631895ad.8.2026.07.20.18.34.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 18:34:39 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: sj@kernel.org,
	david@kernel.org,
	ziy@nvidia.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	npache@redhat.com,
	baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com,
	daichaobing@sangfor.com.cn,
	wangkefeng.wang@huawei.com,
	gutierrez.asier@huawei-partners.com,
	zengheng4@huawei.com,
	kasong@tencent.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lianux.mm@gmail.com,
	lianux.wang@processmission.com,
	kunwu.chan@linux.dev
Subject: Re: [RFC PATCH v3 0/3] mm/damon: introduce DAMOS_SPLIT action
Date: Tue, 21 Jul 2026 09:34:30 +0800
Message-ID: <20260721013430.40303-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721004755.93824-1-sj@kernel.org>
References: <20260721004755.93824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

On 7/20/2026 5:47 PM, SJ Park wrote:
> To me, it's still unclear what is the real user impact, though.
> ...
> Only after understanding what is the problem and how bad it is, we
> will be able to think of different approaches and assess those.

You are right.  I will work with Sangfor to quantify the real impact
in their production scenario -- what DAMOS action is driven by the
inflated hot-memory readings, and how badly the monitoring error
affects the actual outcome.

Thank you, David, and Zi Yan for the honest and constructive feedback.
It made me realize I should have led with the problem, not the
mechanism.

Let me take a step back, gather concrete data on the problem severity,
and come back with a clearer picture.  I will follow up in this thread
once I have something solid to share.

Thanks,
Lian Wang
