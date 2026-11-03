Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716592;
	b=NB/0XQISw74TsdceDOAJy7E74boa+9hRytdzOdsiE69E6wbQ5z3OjwTJ4wWVF4gY7w82
	 8xxl/flDNK0hr8Ze8UOVSD5RJHHEVMZoQCYsgrJrKWqe+68f1+ZXRnxcQCA3GgAOktJEO
	 7njIIejRFAkkf3bOw+OLhtUj4eofRG2Dss7ESJrbKjoEmyqoJ1aUEcXMFxrOSXEh+gOSY
	 D9QipqzwAGaQjgdPz5wlRr0z8zdw3nIJ5igYZjdXgWKnFQgMoR8jjvzRztzT61DwJ62jD
	 Z2YJFXIadcnjhWiiTkQG2CmUZ0Bjkp4iDraJfYjJ/lR/8fqo5jPC8UtfaqpkpI1edIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716592;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=q+a2wZJ2Sr+Br++CEZ+cT4egHi/stEdo2N+elVI+KzA=;
	b=WHFINdMfkJx6Nxwca2so9SmYY4TA13Xw8jZLXJ0beUd9hucSlgq/Vo6wFwyJFg05tcMz
	 1JfGHcQZxRA11/1K0tO1RomCjZzxQemaNMcuBmUcFgXMVjwPvub/Wx3c/0BrnAmS+gDuN
	 lLL5OmqkqCea6DVMXCavwWYkPjq8U0jNe3SBsCH93YwVwGXQbnEkKxJF/9YLXoPSJVk/k
	 MD3DEKVVOK3bwbfgFTTbYRzdLTIW5pPn8MFYVXHvxOB/P8KaRLlznF6p0nGVqW/+5VNDo
	 777TsNAqs2jraveTdJZWd5/GyTXkO/e5OQlMg8tvmxyH+4sfbGHhUxGdDK3xAE4oRYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItKwD9uj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ADD606A324;
	Tue,  3 Nov 2026 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItKwD9uj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88EA1F000C1;
	Tue,  3 Nov 2026 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793716592;
	bh=q+a2wZJ2Sr+Br++CEZ+cT4egHi/stEdo2N+elVI+KzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ItKwD9ujotxRUWUD0Nc2COsYKT7zk/W3ZKPNJr43S8pe86LEco1327TT4io8rfgZP
	 r7uvqMI37FJir7fz/EHwmZuTkl+2jWBDJld8JrwzdZ5O5gwhAPdBsyluZefBXDytYO
	 PwE2/aXli8cWVmRj39WoyjYn/oJSnT3inm4MJDT+0gyMEpr8Su46eYDOXyc/3N3tCY
	 pNXg5uqGYrbtc+1DhSp0dx/5CuLPHQ7p9xAXfoeRZqhyd7yk+dO+KkcX/EvZ6lyvn0
	 33xJJ4nQC42lCThtXWFG6axQwgESejvl5ZVMcDim6Qdt6Aam/ReUceuMPby7AxoQ87
	 uUVOwCpTNmCyw==
From: SJ Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	enze.li@gmx.com
Subject: Re: [PATCH] mm/damon/core: use list_{next,prev}_entry() in damon_{next,prev}_region()
Date: Tue,  3 Nov 2026 06:36:24 -0800
Message-ID: <20261103143625.87764-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103100714.70742-1-lienze@kylinos.cn>
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

On Tue,  3 Nov 2026 18:07:14 +0800 Enze Li <lienze@kylinos.cn> wrote:

> damon_next_region() and damon_prev_region() manually do container_of()
> type casting to fetch the next and previous region from the linked
> list.  Use the dedicated list.h helpers, list_next_entry() and
> list_prev_entry(), as damon_first_region() and damon_last_region() do.

Looks good to me.

> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  I will repost it soon (~1 week)
as an mm.git merge request.  So, no action from your side is needed for now.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
