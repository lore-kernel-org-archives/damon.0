Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794676069;
	b=tvXclzEKvreFVMmr44ZwAM8nkpcvaEgMYoQ4DWsGqHoxCnpT0VNpHZzXwYH9b9l/rxTX
	 S0jWfU6oLLlAzYMNL9AY/1D2h22XKtvvjQp4gP54mKzYX3gIBgaEEDtteB2MK74n+xIzj
	 Ea7QHWpeXkswdGHBLp6yvxrAObqfRy7+Z8wmB0xaR48nRuxx3acSRHVhjj7XhH9pNUJvx
	 BaJPT+Tppngi//XC65MzDJVqtvP8mrnxJO/EaF1uMtQNmnDnVDMUROzjn70LrJH3MEIie
	 bpgge2diB5xMCyaM7sxOtJ+k3mwT0ccgArmisPLpBESD5vq/04+vjsD6nN83mcQlEBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794676069;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZBoCEw6CiwtCNOzOZnUMWIHoxrO2jUoBXpCdLr1vMBc=;
	b=QvfF8b/C0/m9l96qNhQdZvk+mJMJoUrkmrX+37QYU/9leNIprdfcIHfFXa8jW7Lw+gM1
	 fYEEQ0BdGSYiYXtuT/A/y/XkaA0UtJfuNdSKXU6+jc5KsnfPI3QOM07fz/zJt1PuEisMu
	 BU8mQ2HT8bZiAE2UDeXjVe36hs0vXh43AIGV0SS74E84O5296q7HLtodz8lTKYc0MjrUF
	 cB/ZlhBB/79g+5HJo2IjKDfNqBiuUUSyO2ibPVHEQF57AVSzAAtjpqYByLfn4Xq4oSjZv
	 oKzNYmSreWqzWi+HnVehnFi703xG1yGeURTNs6qovi2FNrmcT9sbXzg/11dXQmH1zvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYbsTPPs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E51606A32D;
	Sat, 14 Nov 2026 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYbsTPPs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384DA1F000C4;
	Sat, 14 Nov 2026 17:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794676068;
	bh=ZBoCEw6CiwtCNOzOZnUMWIHoxrO2jUoBXpCdLr1vMBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KYbsTPPstTzbf6iO6y6MCxooU8WHmL4Yjsw6ZTBGAfMwoi9j1DUhateIRsD8zH23f
	 evujeQKdYvb1uxQOfiQHWSunIvh7O8LgPNjNWIDEPq4laSLVH/xkQgvHK92wnG/QzS
	 DYL14EekyTcLyfED8kq7nR0/4Q6Z8lrOViAh0gIu7Fkv4rzgm3l7sMY0mbZlF5Eq9/
	 zt6siETwaDkonabMQTLnzG69YAIXZUp5VUvmBw/0mylDPBml+2nOrBkAL4RBUpwFb1
	 sx55syQnxXmh9zFD7r9w4/Ds7SmOo6wgy2dGrhmXFcnbpg/ZFNDBYHRiR5WgRiFBYR
	 kvHSNMNoccokg==
From: SJ Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] Docs/mm/damon/design: replace "same to" with "same as"
Date: Sat, 14 Nov 2026 09:07:40 -0800
Message-ID: <20261114170741.197407-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114055436.5546-1-lienze@kylinos.cn>
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

Hello Enze,

On Sat, 14 Nov 2026 13:54:36 +0800 Enze Li <lienze@kylinos.cn> wrote:

> "same to" is not idiomatic; it should be "the same as" or "same as".
> This doc has six such usages.  Fix all of them at once for consistency.

Thank you for fixing those!

> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  I will repost it soon (~1 week)
as an mm.git merge request.  So, no action from your side is needed for now.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
