Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026525;
	b=b0rbeL5NJCU9jFepb5iKziJlVeOJefSMnh7I2ZGPyaYxgoNnXACOtJ25doqPedOf2Igb
	 4RGCyTLxYTl7VxysZk893P1Nfx5G0qCP3LenoT54iB5WZf+utqoBdgmrhus0FiZxYRFF7
	 WB/3JkQIgv7pEw20ENLdqTUimzP5qmYn51bpGJAKVjCaJngnBOo8cYD5TjlfOHKT+bg8x
	 F6Q80T8wuGrpC2s0Mf5C+/PMBZMukk0fpwiX/Csg4F8rm3AiSllQDNlqGi6fyZYqlZWO5
	 vS/M70f8v2KHRppprfYPTt8CiCRvUWbA2iWGlXfktvlOYmAYV5XM+BbcKt/HKaMbZZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026525;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xDYkR81v1FXKX7hQ987wVCMZMH9j6xoRUxeWj33C+RE=;
	b=LlF9EcJKRxtatrRdLsquEDz9h8KfUBlit1X2lLHLqlqpXKEA6vbnohUiHbqJeACPnu3U
	 t7d0z+Hacx1y2AU4IjEwUsgdqOy7dKk7rMOtxYTpq9jzfBr0GULkwPjYE6ptHRfJwdxK4
	 k5cWXQVvIvbXTSRZMjM+6RsRryv8ma91xoi3e8ywZ5hNCw7CQtppfSVCSQlTTjr62EU1X
	 YkXZec+iUesCRy1qKIxMVSy5DOm9yWS6eI6xkA9cVIdQvqC9TeOhyF8lkJnaanILa5Wu7
	 By/Ka71Py256OpBQ8GttyG2g2l1gZRFSOFOZ9RU0BCXhKLyXp2clN8X4OovhxOp/Oow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WNWQtX+P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98B2606A31A;
	Mon, 26 Oct 2026 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WNWQtX+P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF951F01825;
	Mon, 26 Oct 2026 14:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793026524;
	bh=xDYkR81v1FXKX7hQ987wVCMZMH9j6xoRUxeWj33C+RE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WNWQtX+PN5J8vdWyESKw+fllDOWalQg1EdkuFJCADxw3GPaO47QNuFMMFyz4U0wxl
	 xj9tXXjXpBU2aA438T5CGyQptalK9bbQWLwkP/3z6fDvh0JLi98k3K0enW3ro8N2WY
	 4I+gk3AnUl1ObIIIAm+xJylZyCmiB22BiU73BN1r4A0qr1uRUSz+EmicEe6H5jDYpR
	 3UUM9RGJiNdMTWvzWj8UUPgcFPGO0Kv2vT6ll7KxDKCfXDp0r5AWh25M7CypjnHY0k
	 udJ6xpCapuv4yOfN47wbdC16tD5+/I/gKp+Ca7Mgl6ajYp8KDG0EMc4SALpzrV9H8V
	 eOtyCS1rYVxIQ==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] Docs/mm/damon/api: fix verb form
Date: Mon, 26 Oct 2026 07:55:16 -0700
Message-ID: <20261026145517.150888-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179301327249.2.1896995843401183120.damon-docs-grammar-6@gmail.com>
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

On Mon, 26 Oct 2026 22:14:38 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> It should be "All you need to do is include", not "including".
> 
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
