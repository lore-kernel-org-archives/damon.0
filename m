Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795892109;
	b=QeNjzv6wRubrNNHBOBvgcBDHWVj1e9mSKSyFivgEKUjJcsgIxEv1lcKdS6w5YWIovKYX
	 6hh4tJOvAttS77QUAlYs9YZV/b9MnToulpYHx8pyNaT7KS4SgKmJNmCWT3zTpf+c8r3D5
	 QeDeWBUFWkcPDmB9hy2fxfIRxxB49BlkofOlgEK2SGnt0x42boyxxqObrpCb0EtSo9ss/
	 gwGkxZtGHZWp9hjxsqVvPDmAXFtTM9bZNAezCS/hGusagpuU2X0EzjuKsvPlVbsXpeWhG
	 M12Y0F4/k4lvd6rvaAzIuxW8wWRqhUjbMnvuRU7GxVxAoiwubDtFaDatoBLnQ0zTgmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795892109;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=x3Hjz9mEIVSyKXl1WCX4n2u3w7wq8qym2uID9jE8P7c=;
	b=MAzu47pGrlg77ekGT+Jr5r6v9qlwQfx+wsEXspXsPjMKDXaVuA6ghLYk44A81HKG7IZD
	 8UGdxMbkRRPg4glgc3ZkZNdlG4YxrYaMwi5beA1IqlB9yiZ2BaglEGN2s3h1jLckXIlIR
	 mosA4OagKaxxppzigtUDhyQM/B3qhIZJqDVVornO670fNUxjQesMmtWLetlVGE+sH3Vbh
	 DD317ix33ZCumbFzjxsNyX5IuLaL4l83FycL9AecRorxxWYllK+zANDzdLKwGS5edwSN1
	 x9jrqragEh1GClZcxnMRqsMQnYkf0lHiBGQZSHXeWSKPHvKulgx9pKeaYqorFanMHZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jAI+cOmP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C4606A31C;
	Sat, 28 Nov 2026 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jAI+cOmP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858C61F00893;
	Sat, 28 Nov 2026 18:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795892108;
	bh=x3Hjz9mEIVSyKXl1WCX4n2u3w7wq8qym2uID9jE8P7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jAI+cOmP1iAKcX8P298CiYFS4ZqU9j6VL5tzC7zqwpGR90Y2GmKuyO7+8GmV30NuX
	 lGI7tgG0B6ETBz5CxqTqDYsWt/CPnMdgj4xkRkQvlj1tP34EXLG4uM/ann+s9MqW0m
	 X4hiA0/Q2Oi/0lhooQDwQ/k7lr7OP3vRrYYa1NqFXrxzVzRruBFGWD32mTC4iYKGuo
	 uivkiAibLYd0CyMAb4oBo6yk42N5f6rRs+3sRpRuM4XMytcbZci/W4k0lgnJLOE7CO
	 HeDrziCwtWCOJWQ+w1fJxltO5oQAXC9K3fSA61gNBiHeJATiHfdJBLX+Naaz7WKr1P
	 H2YJ1sjCKOYoQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Lin Ruifeng <linruifeng4@huawei.com>
Subject: Re: [PATCH] mm/damon/core: let kdamond freezable
Date: Sat, 28 Nov 2026 10:55:01 -0800
Message-ID: <20261128185501.163398-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261128105138.568d35b02dbc712d486a6676@linux-foundation.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 28 Nov 2026 10:51:38 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sat, 28 Nov 2026 10:43:10 -0800 SJ Park <sj@kernel.org> wrote:
> 
> > Subject: [PATCH] mm/damon/core: let kdamond freezable
> 
> Let's use "make kdamond freezable".

Sounds good, thank you Andrew!


Thanks,
SJ

[...]
