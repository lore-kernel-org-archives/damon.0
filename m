Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198816;
	b=TD6hkZ/lIFBLkZuTsv7qS3WUa6GMWMY4YcfAjBI3WBiJJ4kX36vDgpC/SRVB/Bln4D2U
	 cHFQitKfwk1eju+kBy6y/Phj+MgVpr0MCbnVbwBDeV5WlEvODszHhM6xWRPYFHqzC0hKM
	 kdSb7zRCDgwv2X72cDvCkIfGbaOxdTQoqBbJqvR91mRPsz/WNHt2uoA8BohBEbBB2Q2Cz
	 PfcOXdW/uyg68nQpek7/7oBe0jr9FZBdAOS2Iu0rw7KEpUAwS+3ATBfXDCuBvo3qTiEYQ
	 z5DZ0Zs5XggJpiqiE5I/+tStXm9j1zSmr48mNo4+f6HPrmCgW8LdPPLBv8sdvACIkMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198816;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tN77D6Ud1Q99QPI6miaDf99277/QVCzYDZkn61pLmq4=;
	b=RFZXRN0AmiZSqFTpp2bkhvRhQKVDIQ0GGTv5oA8OCDXHi+K4qBiMUvwvXkMP3eLw7Vqq
	 6t1fm8p3tizhF8OzJQYFtYYUp4u35xlQgUXWkyFaVIynlnUjzQvizGRLXSPqyAFUgNXZH
	 wmg3hy2OfYFmjoYONcIBEsSJiFU0ZVuPkdKmaoAOadRLXo7kawxiEDyY2+kHMEklAQTM7
	 tpt45wIYGatc91TCykVIF1+w9Cj4cdIGMgP/QMsryMMxco4X9x1RdPY/Z8kGY4i1uDq+Y
	 XfNH+60BepsaIJdomg1uyU+7StnRbTFMCvfkGsqs9CcH8+biupig7xrjuEv1yv5m+ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0CawaGi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E6B606A8BE
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0CawaGi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF47C1F000C0;
	Fri, 20 Nov 2026 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198815;
	bh=tN77D6Ud1Q99QPI6miaDf99277/QVCzYDZkn61pLmq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j0CawaGix10A0bijXjU4hgiYB1pkFEAyLOTrGevzfDUSCqVJKg3AePXb1b/Woz6hv
	 9St5bur6U9JNk8O0GamH/CE0E/qdj16jl3xLLs3cQjIU8/iACqs5eLZ0hMLO9+uONa
	 UKFcp1l6Z5HWrNMkSXcJQ/gDNyGD4VHzP3dl9IxbNKcZN+WjHCa6rNOZ6A/q0cNqFF
	 I55EXmQskakl/MRLxxNLW19poAqNZCOBtGXwkrlzmCDGMu2KF1Y4lHIAOxaVzKK66S
	 n/8BtAzBWsRP4J52nd6umD3/tXrLbcX76Jme9Yl2LpQDM6Dy4nJYcLjq0z4FiVA3ij
	 5pXqgNi6ze8bg==
Message-ID: <sashiko-outbox-225803@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/60] mm/compaction: restrict compaction to common
 memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-13-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-13-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:20:15 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: "Gregory Price (Meta)" <gourry@gourry.net>
>=20
> Compaction serves the ordinary allocation domain.
>=20
> Restrict it to N_MEMORY_COMMON:
>   - start kcompactd only on common nodes, at boot and hotplug.
>   - compact only common nodes for /proc/sys/vm/compact_memory,
>     and trigger proactive compaction only on common nodes.
>=20
> compact_memory and the proactiveness trigger walked every online node
> before. Memoryless nodes have nothing to compact and no kcompactd, so
> leaving them out changes nothing.
>=20
> Direct compaction serves an allocation from its own zonelist, so it is
> left alone.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D13

