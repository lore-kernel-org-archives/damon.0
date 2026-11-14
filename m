Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640570;
	b=GULqAZ7bUFuo7IW/lb2mpQ1M6favqtEJ5s6zYUfxSLzidK3rZL6oCx1I4PC+qMkwFri7
	 8JU1jQ/I7/5m2HpweXGlzai/qAcJask8/mL1FT9iecQVmiHpUX91zc+u6/zE3ajmx1EjO
	 lm+SXeogFq/qDLo9/0O13OySCv6XbG6T5c95LldPpaXJEWokx1RF/OgiceoRio2FifAE6
	 guW0bQ7Wr9PqNeB55Wxnm6BKZj6QYupEXFVDQNaePAugZbSSwe5tdSYFBh1O27SAq+7Be
	 riypdMmNbprjFuo1XY8VsGbjambUPe+jwnvoeYpgw6p+dcKyOPer3ipbLwuWTz+bvZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640570;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C1r45RKRcRQYaqtk0BI6RlqsBA0Xs69YLwUWq1GGLfA=;
	b=dYNmX6a4DqPvLUTz1zNRHfYiMBJsZ8oXprqFdltpxDI3U4/VRXNFHgw3sb4Saj+jTzc8
	 gLIDuX77zECZN8X9DlbkneV5sqFMsfbPVlJDpPJY0nvyo0YPXQD2mjJDt6B3bjP2PcPc2
	 447/PJJ2T6/25+pZLCoK+exygvkg0Iu08124cq6YBmJ8bmShoBSsuNibVbAetsYhpu1Fd
	 PgWETZkyAT4LW69AnTCprmBfXTfuoc2y7GQz5fK0p8j89qB65k8zqDxCwU0WSA3uGkdlz
	 ZHC3oiRQhxtNjnagO88uiu+Vxv4rBsjfR8LHbN8LKANFH1Of/SXcwoAWU7RTMQMd4XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f38D8FpK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC604606A327;
	Sat, 14 Nov 2026 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f38D8FpK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C641F000C4;
	Sat, 14 Nov 2026 07:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640570;
	bh=C1r45RKRcRQYaqtk0BI6RlqsBA0Xs69YLwUWq1GGLfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f38D8FpKncMWkQ5KBSlzmRXf3D8lgt9fEyr95Dip5T8aapJSH/h4HuAcsLgKERMTj
	 xTxvWP5AqmRYefpw861ZbHkcXJeX/A5fJb3XjtUk49PYvVQd7Fcd8T1FjoGuiEPNmG
	 zWBJt+MRMz8sxvSQuO8S/TZM2L0x96NjQhRh2X5NjoQ5sD5ekjGXM0UBmH25yxQPwf
	 qa93G7OxqsMzajG4GzMTiIbRztnGkZUMhdZtuwusSHEXmD7e1IzQusuhLxRWsET1bD
	 yCIMsZ83JAVatMunkEsf5SORjtumqxFZf/of76TklHQQ6ZLvJIZhOSmCffrwTmpjIH
	 BL1Q7fOWdyd1w==
Message-ID: <sashiko-outbox-214244@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/22] mm/memory_hotplug: migrate offlined pages to
 common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-8-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-8-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:16:09 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> do_migrate_range() / alloc_migration_target() is only capable of
> allocating memory on N_MEMORY_COMMON nodes. The destination nodemask
> presently starts with N_MEMORY and removes the source-node.
>=20
> In the current code, if the destination mask becomes empty, the source
> node is restored to allow migration during partial offlining.
>=20
> Consider this configuration:
>   Node0 =3D N_MEMORY_COMMON
>   Node1 =3D N_MEMORY, not N_MEMORY_COMMON
>=20
> Node 1 keeps the destination mask non-empty, despite being unreachable.
> This leaves migration with no usable destination because the source
> node is not an eligible allocation target.
>=20
> Restrict the hot-unplug migration target-list to N_MEMORY_COMMON so it
> reflects the nodes the allocator can reach.
>=20
> All memory is common at this point - behavior is unchanged.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D7

