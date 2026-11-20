Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155664;
	b=U+XrH8uWwTgtsggjdyBYlJnxECIzV3z50ch5G6JLdISyySLqgFu67mBF4hcSP+F8Samu
	 zc1L23dh1Z+0ej66VNwtVlzdQATj0f5PL65RmQB5zycpoYGhFeb6NMX6LUxjwA8DigwdL
	 cHj+mjlMDxPkHJqNPfo1SsZQGgpdss7Av/uI5W+H7JQHiNKvM1WuGO9qT+tZtUByQ9+gF
	 s0eKsI3K4s+vl82K7nidhQTBRPGebhNokXOOUpPTW3GC3fxJB6DetOudKZ21Oc4Aj9zfP
	 E0CMFg608bXzuD2IzKHTAPMURV1WyAx6kKlI62LMINd5K1GVgKIkcGiIF6nYcrciD4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155664;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c6+uUiXR57v6RettqQsX/j+41oMGlqr1n+LvSk6HEB8=;
	b=kCPb4ka/9hyvsPRSb/t9r7NFtYmzjyNbTa0qduK1Wv45Gw9VQsOvcwSSK+JdG60AxRnL
	 T3+Va5Ak3KIAK6JpqkIWaX/VJBEWacKiIwEr9RPYEILEpcrPbdSGO7uAW/0IYB3S+C33V
	 SuUr7ivmGryaIU5q9XDorXsrL9w9dyYCkxzpnz+sMg71RN8+QsxwhiCGVGqgGJeWk03c/
	 j/13pRjo3hNpa/GNmzwFw37lm7byUWLWXzS4WqgTyosJcoynOLn8RA7iqWbBjZnM2R1QK
	 5rBdiSqL4TheHymDA7/vSIe7WE/XbuRvy32itCcKnPQXmHEkgpS/rO3EVZtgMejtpXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R5vZiRwR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1827606A339
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R5vZiRwR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B46B1F000CA;
	Fri, 20 Nov 2026 06:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795155664;
	bh=c6+uUiXR57v6RettqQsX/j+41oMGlqr1n+LvSk6HEB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R5vZiRwRL3UYhnhzkW3XYXugfRAO2aVbidLvRrDY9ZLg/vtGGYucT3zmCMbNxUotL
	 JbZjcyBE6iHs3Gg+5o3ov0M8iqzYjpmwnNso357BoiUZrFI+UZvrC3ujcwRtAQl++U
	 e007kEfWOmJ2hm0f3O9MfQCGImHNcqymfA1raxuhl+i5T5BJvNzcdDiA5t9seWZsYn
	 dXDXHjHvkgW6en5SrHxGb0rW2HRYMzlT2xcITgNwA8SZ31Y+YNN1uw8D7sYv0HTHMs
	 nCZpiztOavdyNVvUrxZmGEqOtg6hWbPzPKRTbC2PhcAyvpJurgR5JEygYxE/rj1jja
	 8XchiE91H+XJg==
Message-ID: <sashiko-outbox-224552@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/4] mm/damon/reclaim: enable monitoring intervals
 auto-tune by default
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120060741.92121-2-sj@kernel.org>
References: <20261120060741.92121-1-sj@kernel.org>
 <20261120060741.92121-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 06:21:03 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> DAMON_RECLAIM provides monitoring intervals auto-tuning feature.  It is
> turned off by default, though.  It is expected to be only better than
> the default values of static intervals in real use cases.  Enable the
> auto-tuning.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120060741.9212=
1-1-sj@kernel.org?part=3D1

