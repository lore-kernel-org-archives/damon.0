Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4A644C510;
	Thu,  3 Sep 2026 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432208; cv=none; b=mUE+tcQ3FGiSuUtvo50MkF3SBEazfJ2p5GtVNR40ZN6oPJN7xOgb/RnlAqlZ4oUuXKGVeftRV8tiHgNKNHfaZgKSGBE24h1ztH4U5hv9h5nAnRqkJU7ORBn6Tyhka8jqsixtJCWOu9EV8j8ngvEOeZSU7k4NXQF12+3/SFGyjqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432208; c=relaxed/simple;
	bh=3WtGjmXyy8ESK1v2+AY/2+j4fymQ2vsKqVMdj3paIxY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h90QEBCN1Q/5AbO//+mZz/QFCHME8gv1qihiv/PmldRi8EddutqsD0avj4KfJfkkbSYfGYOwffkkr6yli7nKJs3A9d6ToNAjakW4lAVILvIk53hJT/Mqt6uXHbN/c28NmnkWzbx4cfNHzFUAkG3IsORU3u9We2GkqVekLt7tMu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G38Jo/We; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G38Jo/We"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E491F000E9;
	Thu,  3 Sep 2026 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788432206;
	bh=3WtGjmXyy8ESK1v2+AY/2+j4fymQ2vsKqVMdj3paIxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G38Jo/WeqNRMGlJxWDbAvytbz+2WJcpgaoyVuLqBTgaNUITK2lHWQktYarOL7V6bl
	 qHQ6ado5focIEF3Qku6VTXmva8KH7y4Bi1pM5aaBLf7v72T959o7nbbqRGcNhfHiD+
	 ySRIxAB6+Xg/aztbPkiVQ6i6tIt4TA2QOFWpjnvlpf4h/Js5z3ZXpdPF3NnsLYNXOC
	 nl0/jXd8kv+dZ8AmnMwd3x6mkNHPQgy6ZNgJ/pHPZECgnCFHvndQHx7OTZuhKgxJi9
	 eWd6BkffYWPsMgNxjxf0wcw62S5GMUL7O8RAzUJ/rMEhyLn2wvbgIH/0YGQY6Zv5kJ
	 9uI/WU4dpqfBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] xen: use hw_pte_t for PTE range callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: damon@lists.linux.dev, intel-gfx@lists.freedesktop.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260903103002.1091859-9-usama.anjum@arm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
 <20260903103002.1091859-9-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 10:43:26 +0000
Message-Id: <20260903104326.77E491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Generic PTE range and remapping helpers now pass pointers to PTE table
> storage as hw_pte_t *. Update the Xen callbacks to match those interfaces.
>=20
> Keep software PTE values as pte_t and continue to access them through the
> existing PTE helpers. This is required when Xen is built for an
> architecture that selects the distinct hw_pte_t wrapper.
>=20
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903103002.1091=
859-1-usama.anjum@arm.com?part=3D8

