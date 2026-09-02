Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3884643F096;
	Wed,  2 Sep 2026 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346959; cv=none; b=jzOLzAmPdp1y3RF5vDxLWv0WB55HJyXZwr12o0vk/tQ3xqbLxD1FseT4i2zcdMk8LS9fSQBilL1U9XnOuygU0l7Cno8FtkIRBQyjzxuGr/uOr54px0714VfKeKt3pGrdj7tFqHwiQcwg8LgsoJQT3OwooMS+/xYEdLStpd66GnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346959; c=relaxed/simple;
	bh=ZB5ru2yfjwl6kaPTIyzO4lY1SG476L3AvWOBuyfiQE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MwEa9LI3Z/T9Tdyc47gZvRpzzLNAynaUymp3NgYzID1IfoAMA4969pwSnwHGARoxf9tBhtbqYnS5RY6WfkbDmozO8S59maw/AWPH5d5bmGfwsy0sHw90d5M5US/eCPrp5q3HzVCXhOEviMWU3+lkkJfbZ2051ir01fwpCb9Aw0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O16hOODX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O16hOODX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618911F000E9;
	Wed,  2 Sep 2026 11:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346957;
	bh=ZB5ru2yfjwl6kaPTIyzO4lY1SG476L3AvWOBuyfiQE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O16hOODXLKOs3bQrJHtNOTIfv10S/tg90B9wnh/a7B7dA7e9QtDb81Dx/lOjnivIq
	 5GIlOaMeRxSa/g6lvIvLDMyjmRXkVlsqcmkTtbdCXMfRcIj4g3Qpg9y3CemWd9zLvA
	 D8OaVzvm69LgoeG9npcvro6LbChRfcdKClKVsWMX4j2uXOyUoAaWBgK9/2OP9EElEC
	 Vy4cIZtWTnTj7gG4AU9E3VZDfOeexdVpwvPFt581wecR0OmJd5/4Y0BuQQYu8lMdsF
	 tBPIVabktncqXpirmBZbrVTg2ZkaykXXxLNBNnJYp1WglTo1Ifz/5wh0eRJ6c1BRyW
	 NNBkqQDE/tklg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 04/11] mm/migrate: use a dedicated list for hugetlb
 folios
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: linux-cxl@vger.kernel.org, kvm@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>, "Chuck
 Lever" <cel@kernel.org>, dsterba@suse.cz, damon@lists.linux.dev, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20260902-migrate-refactor-shivank-v1-4-9dcca87669c4@amd.com>
References: <20260902-migrate-refactor-shivank-v1-0-9dcca87669c4@amd.com>
 <20260902-migrate-refactor-shivank-v1-4-9dcca87669c4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 11:02:36 +0000
Message-Id: <20260902110237.618911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> migrate_hugetlbs() scans the full source list on every retry pass, even
> though it only handles hugetlb folios.
>=20
> Move hugetlb folios to a local list before migration and move any remaini=
ng
> folios to @ret_folios. This avoids scanning unrelated folios and removes
> the later hugetlb check from migrate_pages().
>=20
> No functional change intended.
>=20
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-migrate-re=
factor-shivank-v1-0-9dcca87669c4@amd.com?part=3D4

