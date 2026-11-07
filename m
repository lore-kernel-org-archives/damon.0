Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082776;
	b=gvETfSto/3id8j6weteVBaImNJqwvn89YNyW2UiAPnoaJugcZkACAej/0M7crrfBBTt1
	 q6dGkuc6X0h2v68K+e5AcQ8fPp5Q8H+c92qorhMfzHqBMWUJ4uE2rBtwkpt/0Ln0FFomG
	 NUQlIRLcRTGlxoLj6EvfFoxh1W8JaQcVOFRGirpkXrdleAqF/O/IPPLZ0oVWEnAckwYRj
	 OUqHpSd0vjaw+JNqiNhbAYPJzimT8mD4BIdI5ElkwzQWpct/k08Dba6qDxAc6M7DUjWOk
	 p7WmlFnoN1WXSOVazKYcf6jhhb5Sc8gpaM5ULIw2vDpiU2meuH9jE5+YiVb2U3xNFGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082776;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1vWZJaydjUihNlWqaIc1T8uh9T4b4IyRY5PC10pVcyM=;
	b=HdR/+Yk+D9LbT6xFzjBTg5LEiitDAHYWgY668gzJGYmvTsK5HJDPiUc7AF//Foa0FMGp
	 uik8g1syBw40fSCrsG2yLntIGwroFG7ZZc5XR2JNk1KPQIJ3+JOqYm8cHSSSs72IdjcOI
	 yK/lxjf3p4zf/YD4gyFOyxDvbm67QnZgqBpfcmr0eRI9L2jr3auk7Ex3B1FgjYdzWjiG4
	 XJ0powsAyBgWlHQq8AufmuOFLyjm5wXKt02o9H3KcA8ytTqdCUr+GZYSQ7KuZ5HnbgB3c
	 r4RYX0YyEvsyLLQADYt6yBFYZR8iq9zEcjHVr22rw0XVdpGFeeltFQXVuFkwB1KpKqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zn5PcyWg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A4F606A331
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zn5PcyWg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DF21F0089F;
	Sat,  7 Nov 2026 20:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082776;
	bh=1vWZJaydjUihNlWqaIc1T8uh9T4b4IyRY5PC10pVcyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zn5PcyWgvwMwpvZwlmhAnFckER0PTtg8Rh1TecbcKc9sbjwJmQK4WA+oPLXNRGyE6
	 YC/w+41xZsbiDAqaPnO+k3qhRiIw+2lM1ix8NmLLC/AiEvmfuc0vMwYMNYD6ybLVEY
	 LuYThmwtNreO6ElJbyNNykHtvIcCdD7W9JQgYhxWEUik1QTvb5TgUiITZikuLB/zNY
	 J292tHWm5n/NWbFc3R5HiVHUavWZ4Kz/51c/Gznvfen2qVYsTvaF+JEk869ooLr0Mw
	 1nseKmDAlBGHxRpMY2uIRa9J23yQ7c6qf+gii/16wKoXvBUdmbHHE7EunVEXgFA0jf
	 zxpk9zqEEo+rA==
Message-ID: <sashiko-outbox-203265@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.18.y 3/5] mm/damon/sysfs-schemes: read
 sysfs_filter->sz_range only once
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261107201001.206120-4-sj@kernel.org>
References: <20261107201001.206120-1-sj@kernel.org>
 <20261107201001.206120-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 20:19:35 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> DAMON sysfs interface reads the user-provided size range arguments for
> hugepage_size type DAMOS filter twice.  Once for validation, and once
> again for assignments to the variable that will be passed to the core
> layer.  If the user updates the arguments in parallel, an invalid size
> range could be passed to the core layer.  Avoid it by doing the
> assignments first, and then validating the assigned variables before
> passing those to the core layer.
>=20
> User impact of the bug should be trivial.  From the core layer's
> perspective, the invalid size range is not really invalid.  It just works
> as having a weird size range.  No critical issues such as a crash or a
> leak could happen.  And sane users ain't do such parallel arguments update
> anyway.  If they do, such racy behavior is arguably somewhat expected and
> deserved.  That said, there is no reason to keep such races.
>=20
> Link: https://lore.kernel.org/20260914142327.92510-3-sj@kernel.org
> Fixes: ea1f204ba29a ("mm/damon/sysfs-schemes: add files for setting damos=
_filter->sz_range")
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@davidgow.net>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: <stable@vger.kernel.org>
> (cherry picked from commit af19aff38d6faea35b10f26cca32d0e54f8aea5e)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107201001.2061=
20-1-sj@kernel.org?part=3D3

