Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012797;
	b=rtLVeUWb4HzdOSvcwOpuaY9W1yDs8eZ98cLVZKz7/HIknkeX3uRx18J7YaeIs9xnCseF
	 Pxa5CXZj2S0xRwcu7MtOa5OdjuRIGRT7o1EelQF08V+stmtIi1lcWadP8tpCs1eyarGHs
	 fU/pozoyodf60/aw5rrws7VLF8QgpcyTWGxy9zxTMU4fehn26PH2UcmDQOQ89GS92RsnO
	 FGsF3o4JUQF/uso8ifPfUvBEK5+qjuFFQAOqcAdSZ4APd/cYNmXUPcXc2afLqO1NwytuA
	 7EKn6VJoR00BWK3AdZAY+aqCa2hBypkxDDaOuPnvQXTJOXRd/F6iiOvsNvJMdDsc3yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012797;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LqMkAkyCJIjZ+7hdft4YzbnxYmR2cyZ8vZsar1XppSM=;
	b=cyYQ9OrYYvfTCrU4PlDqXdiRTU1O3A3qAmwZM00LH7g9Y8+aXMOWNeLT91HdvEuEvGr+
	 SUHWOEXcITVIZZiUyLCOtl214zg4euY5YIyCczqfyQjBWd+7L4Y4eHZKXJdZX47A1Cuf2
	 +wNBD++Et5K2zGytgWtjKNF8K4O+sCX/kB3AMelNK6VCzma6r06okHqRGYXjA9VZsHNL3
	 O8DgLrArZwZ7zCfkNv1F1pgTAbME2717Tb++1cvqgeWtWzuYNpZnjTzZSsmyIw/Ivnf48
	 s5/tIC6JEBMXUjJJRNdBXbThYmOEYypc/OP4Jm5S1DJrXkdIk9l5ANHfJtgnrnDV2KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0RAYUod;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE4D606A31F
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0RAYUod
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35941F01825;
	Mon, 26 Oct 2026 11:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012796;
	bh=LqMkAkyCJIjZ+7hdft4YzbnxYmR2cyZ8vZsar1XppSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d0RAYUodaGw5Sb0xl8M4dWxqTpTykbwM6wuHzEHMuESxabUglNvcgaSoft8P7kc8k
	 pg0rfVW3FJ4Kr+AivmUV6N8PBTVd/zf/aSJoRIFeHRDwCsfCCpRZYyYCyqxsSm7fjj
	 mbceoGxYb5uYcYKrqUl7kKeRg3pibhUiJyxMlX3EIFailwRAsIQ1JgXzrpHsUv+BNu
	 hjJJsIHcABVavSw06a/9+57nmAxjBFUKywpBvNH/cf72ZTiMwGvmdjfdq7QVS9eTgI
	 CacQk5duiELZ9zNQlW5Z5rEpPQm5D9XdYEEz/kS6HEmIm7b6/IzCFQkfUjscuB40+v
	 aj1oxsA6GZWdQ==
Message-ID: <sashiko-outbox-185053@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] mm: nommu: remove unused heap_stack_gap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261026-unused-sym-v1-8-82ca2dceabe1@amd.com>
References: <20261026-unused-sym-v1-0-82ca2dceabe1@amd.com>
 <20261026-unused-sym-v1-8-82ca2dceabe1@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:06:36 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> heap_stack_gap has been unused since at least the start of git history,
> commit 1da177e4c3f4 ("Linux-2.6.12-rc2").
>=20
> Link: https://lore.kernel.org/linux-mm/20140430083620.GA4711@dhcp22.suse.=
cz/
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-unused-sym=
-v1-0-82ca2dceabe1@amd.com?part=3D8

