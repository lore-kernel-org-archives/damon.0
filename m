Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012678;
	b=BTN7zujXJwvDGEicbpqXjQUIJ4DK3aM1L2AC7oupO+QHSm5aPm6+hB+SArCvBZ7qsvaV
	 iE6bIGjwWifmp1htOLL6401AR8zmTVCYZIJmO2Q9D6jcpDSkFBO0uROqYBXm5Z8NlyZVh
	 2ukSG1kT4NEoWxGdVZEoz7WxWE+n7K2lCjKJiNP1sZk1s3fGWovXAwX2aqCPGJcnY6Ddd
	 nnNfe7sw1emxo5ICW9jy6HCjMrJeSNDg4GShH4KXZ+MEWH5GbpJ7kiRs3Ob3szP52uvfF
	 dfWdU7Z85kMulXue/c7o6QvgiR411lr3+x8xQFqqUVfAgFhEPxfftPuQgnw55CLdm6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012678;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SKoVj7aEvOSNwIfMrUr45X8Zuw6gFdKccEisOeSN8a0=;
	b=Zn8nkfGlmFxgxzXagoMARi5zOoS8kUz/X1LV0/jQshp/GIWSlU/mivWleYmp4hLvc/Qn
	 AxNPr8afNp3kfvsNNi41rqYg9UVn+S8zEjkF+mZbV7zfTa9peVp7e0zn8hjFxTwKX5E8M
	 7NM5ekFslvTjeoDVX1tPVci1L7zwGtIeskffcoaXSt9SBx1vlD/R8ISQUv7bB/QF4qOKk
	 +8T8Cbwy7mw2mQdMTfWgTx8QHh7m8/VDx/D7exBoP2xKj5xuFZmf8gmI/c4g3YraiuhgD
	 SHX8CkidKKGkIVFoyHFBeaolBYIZnemirZec/MhRGfvqSJ+5Bwl7j9Yu6Z6RPxB57Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsvZwstf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A778606A31A
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsvZwstf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79301F01825;
	Mon, 26 Oct 2026 11:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012677;
	bh=SKoVj7aEvOSNwIfMrUr45X8Zuw6gFdKccEisOeSN8a0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MsvZwstfFkxcU3kRL2qki9TjvxmhEMlupTJfpsFSL1kpKzeO7R1IjqdS3WkE2PGwk
	 4CA+XFaqUk0kyDYRsvr1ZSzVpNtMijh/kIFOQzThSRU7gM+lpzgVVnRK7qIGq1Cpi0
	 9ttrRX2oT3vQHQcM8c0t5iEEjRqUCUHRzkik5ZMharVMP3Zp4K8N4f/HZOX2MNj/WZ
	 RjqDgCkC+V+H4t9aVNc43FRrMJ0MWg48fAiEQflOzVJKUEopgsNxvn3WrgETgXZ96W
	 UwwT/lGXfxSfrcuaShUDo5JrhRL9OsAvxkFTKu27FN/5R9Gpak6/ZgMSAVENz1wzST
	 pfQ0ELUZ1cQSw==
Message-ID: <sashiko-outbox-185047@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] mm/swap: remove unused folio_to_swp_tb()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261026-unused-sym-v1-6-82ca2dceabe1@amd.com>
References: <20261026-unused-sym-v1-0-82ca2dceabe1@amd.com>
 <20261026-unused-sym-v1-6-82ca2dceabe1@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:04:37 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Its last users were removed in commit 0d6af9bcf383 ("mm, swap: use the
> swap table to track the swap count").
>=20
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-unused-sym=
-v1-0-82ca2dceabe1@amd.com?part=3D6

