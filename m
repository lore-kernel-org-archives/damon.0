Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3FD3446CA
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529694; cv=none; b=oHlpALu6JJicTAN8VbNSCHaopDekq8oI51mTlbjzhcBCHlzcWCWtEiz4IyXQ3DLNpre+0DNNmsylm17fgBtVYtKPfzdTXZ/UFaUFq0T2Z+OpHzia6j7SH+eICC7fjNDeHEplBR3115rdz2+vpblfAI6Dh+vbk9ev8GWYC8ubCjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529694; c=relaxed/simple;
	bh=Z172tjNjqzh5mkYPZ0j1co633i4QB4Lcb4ua9lN1k6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqL3uvQ7mEk61aDQSUk0c1R+DDZyKIR+oFpmtaDGK6NCvBVdGPjRqVDrTaROeoHfVTjdu2i128Kmbg//NWRlMO3yrTrj8K+rQsy7lwwf1Vusk1rFphmT+2pR/O4/UA9Neah1ru6+3cptbRKqwN95ygl+Qor1ucGA3yJZjVcZwAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WejKO7HU; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WejKO7HU"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so601457a12.2
        for <damon@lists.linux.dev>; Wed, 12 Aug 2026 03:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786529693; x=1787134493; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d6i2BJcq4+Poqe237T7rKheo3pdYjmKajfreOcZZTS8=;
        b=WejKO7HUSwVSFg6pL2QykEYauJx6hVVf4yTvTbIsaVei6wsKOLUn7ut3C7zWlKOa6k
         /MaX9PdOs6zexR1mpqJmR18tScy6wmJxvf4aPUJC/UgNrOA+++ObWoDYDMYiPTadSviJ
         0wKnhl5fmOZGXmADxXTzFm6ZTjc5jPdXwghqztpYY7+20Cp4PQz8W6m4TLsD9HXC/oZ9
         cyAUohHO7U3exszFPV9GF5AnlyWYK1PEB2ypt3+nYYDRRI9B/wpLJzfmjFCa4OQE2H/z
         ZqqxSP3VUdj44Yt1Ky71LY+0RU89ADzJpS5cJncUVRUAGitC2ktZ1Oaq1xEkj/ehC2y1
         pOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786529693; x=1787134493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d6i2BJcq4+Poqe237T7rKheo3pdYjmKajfreOcZZTS8=;
        b=Eyg1LfTx8iYQQls/JGkr4osK9kXl6F3U4bwqgZzvpoXjESFh/YSlTdd9968f5m11Cs
         amQnT5aeHPFlmtgYGZ4paG/6EK+ZlAp97FY8SjRjkWvkgh1MLqctG7WHQU2R2Vl4cQge
         zAiXfq5vRKQQqaF3/S2NsizuJJshyDOeUBnv/grmKWvCmBd2/uePfUDKPR/BUnyqsO+Z
         sJ+B3rVi2C2oEFNICL0fb2m/BzpYXvYKDdiKPnZwIXgj6EJPEd+SroYyxvHYj63p4W7x
         5gzvpv8DZBerSfEI5HBhH9Uio3q6wrgqywO7RdV5a4rRhHjjRotRw9cNJA4YU5xwZyHJ
         Y4zg==
X-Forwarded-Encrypted: i=1; AHgh+Rqiv0fmwIx3Y8SKQw6uPufwoF3fv4Sy9JltksJsQJk9441DnCejPFH3pavbrAd4D9DmO/EhIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyuE1DBC936v+jdb1F8MOtP+mwmmjztqvvBcGSMLd+t2TEGWlQ5
	ElyitDja0u/4BTw5vuQURLHoeJkWM+3kIFlkJyvhF86dQ/ESPdH+KirA
X-Gm-Gg: AR+sD10xsu/iuXd08SyPw1k18BoEvXu7iD8b4Q4kOiEUL3i9U0cFHy5jtVOeiiTHiFO
	efxUFW4tOmzT8s74Y7iAfvlPkJU0xJDo1jo6SnvLEs3Tx2u+yxnP2wZCsFCTgQ7KHcXR0Gx2CFk
	XZkHgAsF01Ywl8o9pubUwHhi/L0dI5fYVWFPxxbRInI+08Fi2naxdWuFaZEKlQ9h2woeKv2efVq
	HRsjZigW1vuzTK0HRa/T+hADdg3zA7+8m3/I42T2Dh3TlvfK7xBo3tLcugwNgjU1J+t3N4bcoaa
	MuMVUpzX1Y3r9GTRyLanAH1av/H+doYhhf/jc9FoKQKC93cqt39U6dpnutucM59W42RD1fm21mk
	QNx3fACt6cKBxEEDQU7N1ogb27t1gFjY40Y/gvm+vC4DySEG2mGASBILaKzUXNOuZR7E6nW+0T7
	TT+PLhClo+DScklq1qNOdV7o97yCvSXOC9phWGlQ348Y60eoIUx0snJ9ryy92HPpjl9UklNG0hj
	eU9zDK+dw2RI7g=
X-Received: by 2002:a05:6a20:6a1e:b0:3cb:b5f6:43d4 with SMTP id adf61e73a8af0-3cc3f734079mr3137808637.23.1786529692949;
        Wed, 12 Aug 2026 03:14:52 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:85a:5c46:85a5:ec7:8aa8:72be])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf678ca12sm8940240eec.20.2026.08.12.03.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:14:50 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	damon@lists.linux.dev,
	david@kernel.org,
	liam@infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@suse.com,
	rppt@kernel.org,
	sj@kernel.org,
	skhan@linuxfoundation.org,
	surenb@google.com,
	vbabka@kernel.org
Subject: Re: [PATCH 0/3] docs/mm/damon/design: add explanation of nr_snapshots
Date: Wed, 12 Aug 2026 18:14:56 +0800
Message-ID: <20260812101456.3845-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812100433.6288-1-aethernet65535@gmail.com>
References: <20260812100433.6288-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Aug 2026 18:18:38 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Add an explanation of nr_snapshots to avoid misunderstandings.
> 
> Liew Rui Yan (3):
>   docs/mm/damon/design: accurate semantics of nr_snapshots
>   docs/mm/damon/design: difference between watermarks and nr_snapshots
>   docs/mm/damon/design: fix typo of max_nr_snapshots
> 
>  Documentation/mm/damon/design.rst | 7 ++++---
>  include/linux/damon.h             | 5 +++--
>  2 files changed, 7 insertions(+), 5 deletions(-)

This patch series still contain some error, I will resend them later.
Please skip reviewing these patches.  Apologize for the noise.
