Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B5A2D7398
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269943; cv=none; b=MOpbh7MGp83XjZsucNTjxlofoPhPlGhc+ZFRzVlp2ki7p2mAs/lQig0PwUj54EhJD6pTk0bGFKnRfU9VO0ybRvDuL/BYTx5CQdHQFcW2GrdxKFiywxp2k+QvW8atMKbJ8LWKyUu2nATZTEFYqVOOXUdpqC/Wus2MVQfGMW8KHRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269943; c=relaxed/simple;
	bh=WEBo8dkIQmoDMtp3mSlWu23fhqxB5+sFb7odNhegsrA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PFl1mATj6bt2IvtEyHBvBzmC1Y1IRjYDzRUfEZYNrUDWR8dvkpUXy6V09wj4HdMFRacxW0B6ktuei840bgQvkUUM0Fgph6WLktwYFLSRfFx1XB8jGMWNmt93Jj62rwPyFxG8TjO6ShrbYUaoNjncAKo9RliK0MKKzizCDYZLfDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xfrqs86i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xfrqs86i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703371F000E9;
	Tue,  1 Sep 2026 13:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269941;
	bh=WEBo8dkIQmoDMtp3mSlWu23fhqxB5+sFb7odNhegsrA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xfrqs86irFT7xBwWs0qKO0T66KcRPJBplcHa8dgzmgpQUjj1XnimhrL435558BuE6
	 LCcSIO/cdqZ9yKSOY+XZd2y5vpWIZ/de9kxG+1L/hugPZqFiY3NRITkbIU76l2hRcz
	 Ssw69LVhvMaWwll1csubrT/LJjv2RL5fzErQ4aW9emH6+sA4I3CPfghxSkj5TZNofx
	 S2EBLEeou/d1WdeiilKfb7iESnr29dAoSubDlybZEY6GuCaoQEHm+ywRUtOuWL2/Z8
	 RoOpWKPumLJ50x34hiw3RfA7pCdH8tQkpUtfCOw6HCU64Rj61M3+p7oFtw1up4Op+a
	 VTiRuEg8CnhEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1.1 16/17] Docs/admin-guide/mm/damon/usage: document
 probe preps sysfs files
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901132506.99243-17-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
 <20260901132506.99243-17-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:39:00 +0000
Message-Id: <20260901133901.703371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON usage document for the newly added DAMON probe preps sysfs
> files.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901132506.9924=
3-1-sj@kernel.org?part=3D16

