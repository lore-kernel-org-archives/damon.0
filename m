Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22898463B8E;
	Wed,  2 Sep 2026 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346970; cv=none; b=LEw9b2XIBzfnL/uvECXQIaw90A3zEvtCcoeWQhv6B5mposR91d7Ck1hArMe2Jo8fzF3CMh2Qw1xqperQv6X/kvGURVMxcLkLKBVyrn709RD3MQcvTemQLTL0JqOlV5xttPMCNFph+PaSRk09s2L3YnFdfZzMNycY60XT2C9pyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346970; c=relaxed/simple;
	bh=lqoqBfQ3fq0bGckUiEs3jxMoAutJmsL2HiYIdG1tMhY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ir+yV66ja5v7QRM9aaKaQBZpSofWfAhyO3XXHPkVfqhIF4aCy9D79ATq3oDT4sNtHr3zyEWGy6NHFAiyRWFnwUvx599EHYc+EDekcbwA6SYvF1UvwX3nMocHtC8MtCOxFLwBS/TBF5Xzmkq0g/BpbUkNlmaalb1R9OoKNnRgSps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amc3ToK2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amc3ToK2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A0A1F000E9;
	Wed,  2 Sep 2026 11:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346968;
	bh=lqoqBfQ3fq0bGckUiEs3jxMoAutJmsL2HiYIdG1tMhY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=amc3ToK2zYyUEYO9Wt6bsmdCMTHI+tws4j7LURyAqTqxOU8ZedjPyJMOThxIKZjdE
	 e+vaV9QUTGWalvuk1xuBpHW6rQxtKLgM2KbQVbw0Uqut+TzDzWn77Xyu3Cm2Mch+Nr
	 7h1KLKMX20a1lHglAyHGdasKF7ILE9spuFqZdD+LDON07GxHgXjwfXBVKpPKru1Gl6
	 n1EsRmhfY3KmC/urBc1zJCYnPEi8kqhj1Coe1shd9bWQIpg4xaidXC8PQsaUKVpO0X
	 +DOMYTSC+Sf9oq7a36VKQwWSZS2eS2nwf1y8hMhJaK3ob3oNfrYQhw4P9uOPYZLeQr
	 3vfb+X5lcUquQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 01/11] mm/migrate: extract folio unmap phase
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: linux-cxl@vger.kernel.org, damon@lists.linux.dev, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>, dsterba@suse.cz, "Chuck Lever" <cel@kernel.org>, kvm@vger.kernel.org
In-Reply-To: <20260902-migrate-refactor-shivank-v1-1-9dcca87669c4@amd.com>
References: <20260902-migrate-refactor-shivank-v1-0-9dcca87669c4@amd.com>
 <20260902-migrate-refactor-shivank-v1-1-9dcca87669c4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 11:02:47 +0000
Message-Id: <20260902110248.73A0A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> migrate_pages_batch() was hard to follow with the unmap retry handling
> inline alongside TLB flush, move, and cleanup. Extract the unmap phase
> into migrate_folios_unmap(), which fills @unmap_folios and @dst_folios
> for the steps that follow. This makes the unmap phase boundaries clear
> and the code more readable.
>=20
> No functional change intended.
>=20
> Suggested-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-migrate-re=
factor-shivank-v1-0-9dcca87669c4@amd.com?part=3D1

