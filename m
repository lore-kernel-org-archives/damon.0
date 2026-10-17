Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBFE3A48E3;
	Sat, 17 Oct 2026 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792252912; cv=none; b=CNLbZ7p2BAl+QlH0xI8NFj1GY+cEUCzo6uzalNygbjZ3UV1xOkhi4alu5ILoBfg0Dgii8BdMtw/MfKI7RRk0toTt+LHqHtmIM579ENVDluinruxlwr7br0hk8tK0Afv4MyTn+809voLMhQxEO1M+Ibpmcot2wAFaAiYrJRacneo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792252912; c=relaxed/simple;
	bh=cOuSe420SaYgq2rR7/1HrW8gJGG8cHX8haJr9RrZHcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuWxGhL3oL9akTSThesTOW4H9DOOI9GIaieGXMMANyFdX0F45pOdfr4jbsSynFkTEUE0xBIQvj/PUO5jLkoKU8lZaIiVdFoHXgqPN/vIuZRxzonieEp+0VRWoAFXDneXBf9Gr+E+EV+JTNRItf53FXRYyGO0SEkBwxpcKOMQSpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozF/zla8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozF/zla8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560211F000C4;
	Sat, 17 Oct 2026 16:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792252910;
	bh=eZnlanUf64i7B1h2EayrDWaBYC02Orq3PWtev+6wUVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ozF/zla8N+wuHiDl4LAVU1crVf3wQFOQwFfB7d0lA2Y5HvxfNab2pvaTKfbhmJdSU
	 W6bK4+w1kEH4ciueTBuxkMOPHOghVgcAzq+7ZQg1wL0VxEuITSUlZZHORVNV0vTiDN
	 sN8ju76U+QIKAtJK8QLfPlV7Zb84jeJbIEc1XrNrbpEjG5sl93aI+ez+Nn9XIHnLtT
	 UN4Vy5PiPDTRbb4xv2JtC3EjSvMCfAcIgej5XhAP6rqMXIvG+ybAfZrLKOfWMHNRXu
	 VE2lbRaq5Iw/WOVyi4W2HPZSgxPpX0DRWQuW4G0brI5l449KhubASY1Dx1dbmDSRbT
	 u4ZSvSGXkuapg==
From: SJ Park <sj@kernel.org>
To: Karthikeyan KS <karthiproffesional@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs: make next_update_jiffies per-kdamond
Date: Sat, 17 Oct 2026 09:01:42 -0700
Message-ID: <20261017160143.102364-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261017063152.994182-1-karthiproffesional@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Karthikeyan,

On Sat, 17 Oct 2026 06:31:52 +0000 Karthikeyan KS <karthiproffesional@gmail.com> wrote:

> damon_sysfs_next_update_jiffies was a single static variable shared by
> all kdamonds, so with two or more kdamonds using refresh_ms their
> threads race on it in damon_sysfs_repeat_call_fn().

Thank you for this patch.  However, I think the same issue is already fixed by
another patch [1].  Could you please check?

[1] https://lore.kernel.org/20260902002725.108635-5-sj@kernel.org


Thanks,
SJ

[...]
