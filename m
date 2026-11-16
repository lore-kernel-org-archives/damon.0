Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842005;
	b=ZzDH3cJ4Z3HPa1iPddWbS7ncykBxI5e5Tpw9o+4wf69dRjhMSSdLaGlyCYnc8Un4VI1Y
	 n8xInBZ4hVyZLhspcnLMtuiS4v1hNlP35wWH6WXrlB/Re8GebtI6U7Sx04CphtsjTHIko
	 GlpheliAZpyPROlLaO3h2maLAWC4LdR9gN1BSAJVtjKeGvfdqF1DPz/ctX3KCIL4HDTQq
	 5j8Fmb8iZGBm0rTU+v9FLQe7v0rLwLkhzhjrIv7IssYT0KjtmngmRLtAkqM/ojzjA2VbM
	 fb8pdMDlnn7BI4U2Qgq1bK5ya2NaCzfR1Y5VG3l8PjLbj1ms43x1vnil9aF1ncAy61g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842005;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g5ZRJiPOBXH1G4LurhV9pfgX5c+QzGU61IrAF9FWMGg=;
	b=Gu4rdmg7DBhSXx8+CMmBtUdFeRQvVaroemLvMXscEluKFE4NlehweuYCYTuI1Z1+Y7BE
	 e/jPryxolS49YT/ddcWjDokqbq5Idgh/qGOaHHrkNsLDcFeayFEimkawo3tacrD3ShE5W
	 GrR9CIB/BmlXnVos4E3i8AZQQCit2IhtF5vMThew2CwpHWJN+dvoYjsWZzLJBXlqBWR1J
	 TyShXOXlb4rplCtSQJ3mgvYz90QwGMdGM9+6FbjSkS6ikls8B4wqlMcQYqdZ2+vyAgFnD
	 kLsu8bKZv8L6RR9Vsz+BslB0elPrpKiUOw0KJVufPQhkQ5w8LZ2ZbPWkrS2DVc9fSEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASZQEKG3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2DC606A32C
	for <damon@lists.linux.dev>; Mon, 16 Nov 2026 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASZQEKG3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D2D1F000C4;
	Mon, 16 Nov 2026 15:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794842005;
	bh=g5ZRJiPOBXH1G4LurhV9pfgX5c+QzGU61IrAF9FWMGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ASZQEKG3/8GcElsSqBoJZznQ/UyCeaLcVUFZLxCXmqWLK9YUKFosJZc24RToYsyT6
	 gSRdqKpDAGhBb93l4UtmrmMWtAxvgXP/VsV93RH1emVxKI0U5WSNWR+Jda85SctnRH
	 OY1M6faIqHPM6+rvX8asUcg0YWyCV2hTBRO9dQPOsQw1CP6SWAM26f2nLPMH1fugQB
	 qtrZfQGM3md1wgYD1Trte/34tOaiG6MJW+JCvC2jx79ufORUNFuJXBYgobQdbtjhs0
	 AOXJ9jF7nLURcUa0lxJCR4JOLxPKC5JET85o8p+O0NkLVaZpPUc2PL273WQGCPRkud
	 6U4Gwaw6qlqDw==
Message-ID: <sashiko-outbox-217243@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Docs/mm/damon/design: replace "same to" with "same
 as"
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261116151057.81692-3-sj@kernel.org>
References: <20261116151057.81692-1-sj@kernel.org>
 <20261116151057.81692-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:13:24 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Enze Li <lienze@kylinos.cn>
>=20
> "same to" is not idiomatic; it should be "the same as" or "same as".
> This doc has six such usages.  Fix all of them at once for consistency.
>=20
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116151057.8169=
2-1-sj@kernel.org?part=3D2

