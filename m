Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94160382F0F
	for <damon@lists.linux.dev>; Sun,  6 Sep 2026 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788726116; cv=none; b=j/pJAf68vjAZBS0BZuF0KHxKNXQ76zqhjnmG5xMQB7yTfVAe/xXAj+zl7d5/iW5jeTk3LUyZ2HCw25EeRh7OgfP6EGgXtOfM9Y1WO+bvcoaUS/rlD85AY3z5OItpLGEHboMQZ4EW1gDeJ/LWjYzVmOsWVTuhwc/1JctkKO9ulyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788726116; c=relaxed/simple;
	bh=uiVs8ACr86aPl6ohs9AMYW8OEEoJcrPw/Gm2pQGwx3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fU02t9HBgWLd9n3jL49R//2YHwP9A3AFGBU1xTzz9CUbxd8Us4JmGwNFKuy/lgCX7BW3V0yx73mlR2UsC6Tg9+nW0locL+WCJw/pZzJsUy2EyJT+bpAeGq9hP11Iypt7a5ny36DZUHErerPOXas7Mm+zUuM0M7X1vF1smbUjwi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bk9piSxT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bk9piSxT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF92B1F00A3A;
	Sun,  6 Sep 2026 20:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788726115;
	bh=s1ciflt4YYLpwfBXfLBfi1L+uuptAFxm4L62NV1UG2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bk9piSxTaCfykbNxZ19z05RZktTC6DlKG4UhxKrFhhdeOFwsHtDT8E/1M4J3dGAo1
	 er+3Q0cNbppmp/54GowW9XzbZQPoi2d5z3GdUPoZScAQNSM2uZyao9b7218vy51pxs
	 vAUP1cbZbCjohrbMAAFf4FiQbKqWNJ8mCsAomczEiQAJo2Pkyb8mdFA03Mh0ayPmz8
	 Y1HZooACpvBSU3HbgqRH/PpbSvtY+yQEKi/FNBSONUksBJnclIuAL+DG+dZk29cwBD
	 AF9U7GDlYme6h+ClZ+z1HELZFMSdteUxASdJjZ8xG7iADF4dkiaN69Cz5ddWyJvvvh
	 igYj6ngoZhXoA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon/vaddr: avoid hw-driven pte updates during
 damon_hugetlb_mkold()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260906195417.103263-1-sj@kernel.org>
References: <20260906195417.103263-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 20:21:54 +0000
Message-Id: <20260906202154.EF92B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_hugetlb_mkold() reads the page table entry into a local variable,
> unsets the accessed bit in the variable, and updates the page table
> entry with the updated variable value.  If hardware updates the same
> page table entry in parallel, the hw updates could be lost.  For
> example, hardware-updated dirty bits might be lost.
>=20
> Avoid the parallel updates by clearing the page table entry when reading
> it together, using huge_ptep_get_and_clear().  If a parallel write to
> the memory is made after the clearing, the hw will see the page table
> entry is cleared, trigger page fault and wait until it is handled.  The
> page fault handling will wait for damon_hugetlb_mkold() due to the page
> table lock.
>=20
> Because hugetlbfs is an in-memory file system and hugetlb pages cannot
> be reclaimed, no critical issue is expected to my best knowledge.  But
> definitely this is a nasty bug that should be fixed sooner rather than
> later.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> [1] https://lore.kernel.org/20260830160545.98969-1-sj@kernel.org
>=20
> Fixes: 49f4203aae06 ("mm/damon: add access checking for hugetlb pages")
> Cc: <stable@vger.kernel.org> # 5.17.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906195417.1032=
63-1-sj@kernel.org?part=3D1

