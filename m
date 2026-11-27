Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795800402;
	b=JVrxTrmw6b55Qd6fOkDuRGCILb/NyBzzHsf4vyE6U6EWfMDLRBoP7H0vFGZ/z2xbcPHu
	 ZtbEWvd/Duak2QXJn58ohgqt6gypDAWCmcKg8NEp2il/yUU89XlDY48W7V6XzEh7VkCWV
	 JSXVmjd+nR2ZCr/7WY7FcPf/ji/aXnoSGCtrsvUm5hY1yraAKqfr6Ax4Z3zO45UDqO7oX
	 2Ri4vI7J5eny4LXj5jl47cNkH+pAyi26DDVfHYU3uprmFjsUfZN912ZrLvrkU29+fHKCa
	 yC8F0cGP8pNBOFA0EByVzkj9Vamwjs8okQAib2ppox8lxlhqML+ITt5/zcBGERfDl9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800402;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3XHeNf6dkhJt1onpBYytmylIIsDYpini2AOV7gcbkiQ=;
	b=ybYVRAxDHBtJ1T+9MQLNzrGxKsehYjOuDfSqOvvlaZfy0Q482B4pzpLX4CtBJ9k4yduL
	 KmIvCDR/miMZcBNu7ZrGSJBCgO/b+8/Ke/ifWXr5eq5TkKC0F3FOHQ4GfCjmhfktWbr+8
	 L9lah0Y2+4qzMkG2LzPgoKsa7zhb38nF6x+sApkqOY2zt7+93VTt9puHlt8mZWJg9XiLp
	 lxdM9z0xSqHNYPp8NHzhA6aynHtFQteHDqj6QUfzJk7815y/D+28xbgIoJ6yzktHcSRl3
	 q0+/5mcReojBPndODpzTFP7Io7vlSsQ67lvRc5jd3FMBuVApyRoeOyo3z+hDxXtbVRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SPts2HZ2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC9B606A31F
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SPts2HZ2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B3A1F00899;
	Fri, 27 Nov 2026 17:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795800401;
	bh=3XHeNf6dkhJt1onpBYytmylIIsDYpini2AOV7gcbkiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SPts2HZ2fx9HHbsj96xKZ5JkPvbMxFMiCsuJqX40UgUB41Tk5iKcWEy88jd3gIr5G
	 PEmAXODN9mTm1Oku09ou3FReTH2j/a8GS7OlN7+UsiycXy0kDhHyuYZg9qlPOH/Zay
	 phuMzu2TLPHR8xuHYQmNplqQhlGFKdz90ajuFiTyHia48TLQZJW/e5ZoAnlrJiLetC
	 2NLN6reXqq8XxYfUFMCxLjchApqd9opVha7opkx+rEWkbh7CTD/RfL5L513spIN5xv
	 Jqsm/+5zx8hnQK+d2YDEqftTVpEAqLjcrfjPtm/dPOeEK5XSfXWhJQcMYB/FGE8OaG
	 i0GfUpAtH39ug==
From: SJ Park <sj@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/4] mm/damon/sysfs: refactor state input matching
Date: Fri, 27 Nov 2026 09:26:23 -0800
Message-ID: <20261127172623.88602-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127022945.8243-1-lianux.mm@gmail.com>
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

On Fri, 27 Nov 2026 10:29:21 +0800 Lian Wang <lianux.mm@gmail.com> wrote:

> Hi SJ,
> 
> > It is easy to mistakenly make the order broken.
> 
> This makes sense. The explicit command/name mappings preserve the existing
> commands and state read/write behavior while removing the ordering
> dependency. LGTM.
> 
> For the series:
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>

Thank you for reviews, Lian!


Thanks,
SJ

[...]
