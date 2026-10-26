Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012515;
	b=UDpbvwpBIALhMdeR5eLx7oWvVoejEUKIgm3uRo9ZHQ1Zc/O5b5iKkSarISTHlAoIbqlf
	 ox6CWlgkjdHB2Ms1ha3tVNT5oT7BNjL9BSDvx2hn2Od2+di3PG0S3Qp3ux5WhgiB0Xepb
	 UfZGjQ3NMrFaWY4wu6ezQ6mdmNWwSqejKBWiYDyO22auHE2evlQMtjpN0oxYRJO3RXeAB
	 2uXvtwjlzAE7wYJXYBWSp3Zmq59Pc1n7BBttXLDIGFw3AUr1asoiGw97fdOHgwzHSCgmK
	 u0JJU2IXiPllnALfoU8Zg//SUo5eKb0GwIqtuuqW0bIKd5vCQo8/MMnap7ft/DQ01uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012515;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WGVnhwYDQylt71wQYBV4rn0kuaD0rHMRX7CEJ9aJwAY=;
	b=RFpebd1c1hD2as90c40o9VL1wNVXplCiZ6bsEI0nxNn5C3Y7ieCG2kuifYWEALgHjcqY
	 wUmT0hDlZMZLqsopK59AKTOfIoeBPZQJeRKX7H6u+ynTgeitETOV20RcmLVof0NnohqAC
	 HRbt7ZOoAPDpekM5sgVa324928nqKlxWO/U+GjEzw7Wk7QqAJYujG2ALIeJHpNkPdk4Ri
	 KoErgTgBR/T4VHmzwiVNOpRf/KxpPKMN1w7KvMTa7RUkQAB23B1kZQnO0JkxaJT2U4tUR
	 H2Qdg8ikGkSihsHH4bBy4IsIzT+JLbfQjVhdbdpoNo5ucuF9GtOXBAu1QE5LMkocZfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YdBXtSC+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D553606A31A
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YdBXtSC+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF79C1F01825;
	Mon, 26 Oct 2026 11:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012515;
	bh=WGVnhwYDQylt71wQYBV4rn0kuaD0rHMRX7CEJ9aJwAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YdBXtSC+IQa8CqEylFjqr24Xi9TS+SZ7b+PvUsFp+u8DE8ZS5HTHBKYM9pMTYGqF8
	 zx39VIJvtlkfk65i3CcaiCVI0BY2U1jMFgSRxC1v5nDtS5TCQZGjUMQLLzRuKz8cnT
	 TKM42oBpxIJCMBDWVmTqgnGBZt5la1yqUEAH2pwLMgDQWcDvv5z51Ep5L8gvxxAQG4
	 OIo8ysI/Wd9iEEXGln/L5J8xfihfdCjn3WwBl4LonSitCNe2nvM57O/Mx4PztbcnrV
	 uAvWPtoPferLNvcbFKxw91g8TOFvX7dduYfPyy0OdAdQ47kw7CSdDfnl9YDLB+Fl15
	 47RU+akYhuooA==
Message-ID: <sashiko-outbox-185040@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] mm/page_ext: remove unused page_ext_iter_get()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261026-unused-sym-v1-3-82ca2dceabe1@amd.com>
References: <20261026-unused-sym-v1-0-82ca2dceabe1@amd.com>
 <20261026-unused-sym-v1-3-82ca2dceabe1@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:01:54 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> It was added in commit 9039b9096ea2 ("mm: page_ext: add an iteration API
> for page extensions") but has never had a caller.
>=20
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-unused-sym=
-v1-0-82ca2dceabe1@amd.com?part=3D3

