Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012571;
	b=pQq9ifkMzryQUzuDIynr5BAL4uL0gIbiw52C8tMNDbW1sQr8SyqM0iy/4TypngzZnBJ0
	 Q5WEJUwPZEUbUL95y4LLzZ/nE6yhk/pGTsXCRSi56SIwIDBFUczw3UrJGgnGjrn8LO8fo
	 fbtiWFcGoK56P0e54AdXJD73V/tXyth0BGLkKOt0YPbKwCbVASnmIRexUOha05ia/33Dn
	 x+k/xboW3S3lPvup8pSn0+Yg1v0ow5xEDcAWxlqUIEC+YmzSrzqXrPF3qaiXdLqyWlgL9
	 FfmvAqSOXTFXF/F4EeWQic3gggeIZXr5vScpBUizFyA0KChUh7LzUt7LD3lIqTn+NwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012571;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iy4fxgFOOXZ1dkUsh+Veus7nKzA5raA9U3iRu2yWwC8=;
	b=YUTt1NKHEz5w03ey00f9MM5XqmgzVimSLZXr5AuZlKG+LI6aAb7vVpBsGzh6Dplb6ozh
	 h+KgzcFGwN381CagpWLo90Ab5XotP+cVZzN6v7EhVU1BSNJz0uI0UyTvcHEwOvRtwe5Av
	 IxZlIFU3fDjTRMbdSAK6ls7Jv8amfCQenacpZmE9EiI0DYXrzpwZRqRQW3HaIrRy7etEk
	 MdNJb2ILdZ8cODn96871dQdzb8APBryvCDQeQh2bdMoeXVWMBknTUpnGfXYDQ7tUJtw8r
	 qYVaqKtyRz2ebaw2LUhLJyA02Vuwp4wDOmAH5WwnzXb6sinuhtH6Wl8snq6+gUkxLmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aCisSzb9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35F1606A31A
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aCisSzb9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69051F01825;
	Mon, 26 Oct 2026 11:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012570;
	bh=iy4fxgFOOXZ1dkUsh+Veus7nKzA5raA9U3iRu2yWwC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aCisSzb9gcVYSzvj+0EOpS9+m1LODX6DgoYWjxzdosu2x7ijOcnlZ9RdNRqlPf4Ph
	 c+MKSnv5MyPcessh4IJntIFrjJbocNFiq8ooLkbnQBM6lNxPVKLAV5EkFrMDipS6pQ
	 qrNdp2N4QwpWJ9eXGAE+xBNUp5PFH+B7JtiZ9nHrfGjzC2NzUKpc/iZ4L3YyILCTbw
	 u3ftfPxhvSznfC1DS9mxXjfADa4I50WJ3GQtsgONNgIrV/56Vax2Jd0UAxNovcgccW
	 ZWGIzqNfaR6ey9Ia2VFQepxdNkbYrwjvyiW2hvjUGsmgPb9XRCxi5ih4/dWSzMCDrk
	 roJAcvNweFEzg==
Message-ID: <sashiko-outbox-185044@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] mm: remove unused helpers from pagemap.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261026-unused-sym-v1-4-82ca2dceabe1@amd.com>
References: <20261026-unused-sym-v1-0-82ca2dceabe1@amd.com>
 <20261026-unused-sym-v1-4-82ca2dceabe1@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:02:50 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> invalidate_remote_inode() lost its last user in commit d73065e60dcc
> ("afs: Use alternative invalidation to using launder_folio").
> mapping_clear_release_always() has no callers.
>=20
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-unused-sym=
-v1-0-82ca2dceabe1@amd.com?part=3D4

