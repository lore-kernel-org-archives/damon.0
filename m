Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D571B7262A;
	Tue,  2 Jun 2026 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416486; cv=none; b=jaE/ceplgEg33cvHAJNvaCndC47X+A2X8uMufy3nCkn+G4BduGLlYaYZdbImqJax2Y1ZDsFazgb7FzOvW+uk66+azzGr69BDPksaa3vizkxWy6rxt7dmsiaUvQYrY+hsDa6xHw7nHiWnTIyvPCnzCD5S1xJPnpUwgUgSAPKnwuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416486; c=relaxed/simple;
	bh=EMzfNq+ehdXO/Jw3X2hRGcEOYo6KK0VIVTw3/YK9NuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWAr8fVcBJbNLVYsEa5OMcVfip8RvdC/YodI0rGdX69b4j8nIC9p4JPoDrSZ3NceDKBf5L9/SOQgq2jV1J9Sf90mm26L11fWA+1NJf5O36X9/V8PECsBNY1DVdHdMxUZnbMvnTmNw3sHFycABc8zSoXz4AILqgRAL2vCn0uRYqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9OEVz4r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9OEVz4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56CE1F00893;
	Tue,  2 Jun 2026 16:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780416485;
	bh=EMzfNq+ehdXO/Jw3X2hRGcEOYo6KK0VIVTw3/YK9NuA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=I9OEVz4rylaFp3pNevk2zHSWkGG2xI2nyzD4N+VrsqzLiK1w7rxT6CEqu8obDWZrV
	 ir563Os2LvTO+r32bkhjQy5lRULt4Un5DdFFZymuxhsfWbK+SpHm91nfvdIPDUjoDX
	 LrVn3eYMXPMVQ4ezEpXf3grANdI58bDPZA6kzFBX2aiEPELH2AXKLEHljNlWdgTyVo
	 0SWGPlHjjXiahVuTpvmWHoMprGDGx/DDHMqOmHQ/1AZeCrbT/i8XS+KHZYkAgaAEte
	 R1bjzdWSobiftdLUC67botuwZLso+80sTGQkFhfiv1NgGalqM+THxadGthdkCcLHn6
	 +Pvw+93fVg6gQ==
Message-ID: <0867dac0-bc48-4aa9-891f-2066a3eff989@kernel.org>
Date: Wed, 3 Jun 2026 01:07:39 +0900
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
To: tao <tao.wangtao@honor.com>, catalin.marinas@arm.com, will@kernel.org,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, akpm@linux-foundation.org,
 david@kernel.org, willy@infradead.org, sj@kernel.org, kees@kernel.org,
 luizcap@redhat.com, zhangjiao2@cmss.chinamobile.com, kas@kernel.org,
 ljs@kernel.org
Cc: hpa@zytor.com, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, jack@suse.cz, riel@surriel.com,
 jannh@google.com, jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev,
 nao.horiguchi@gmail.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, pfalcato@suse.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, damon@lists.linux.dev,
 shakeel.butt@linux.dev, ryncsn@gmail.com, 21cnbao@gmail.com,
 jparsana@google.com, dvander@google.com, zhangji1@honor.com,
 wangzicheng@honor.com
References: <20260527110147.17815-1-tao.wangtao@honor.com>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260527110147.17815-1-tao.wangtao@honor.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ey4l15FF9oEWH3xFySCAaCAx"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ey4l15FF9oEWH3xFySCAaCAx
Content-Type: multipart/mixed; boundary="------------YusAIRMqlR7LLXeBVYeRGebJ";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: tao <tao.wangtao@honor.com>, catalin.marinas@arm.com, will@kernel.org,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, akpm@linux-foundation.org,
 david@kernel.org, willy@infradead.org, sj@kernel.org, kees@kernel.org,
 luizcap@redhat.com, zhangjiao2@cmss.chinamobile.com, kas@kernel.org,
 ljs@kernel.org
Cc: hpa@zytor.com, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, jack@suse.cz, riel@surriel.com,
 jannh@google.com, jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev,
 nao.horiguchi@gmail.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, pfalcato@suse.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, damon@lists.linux.dev,
 shakeel.butt@linux.dev, ryncsn@gmail.com, 21cnbao@gmail.com,
 jparsana@google.com, dvander@google.com, zhangji1@honor.com,
 wangzicheng@honor.com
Message-ID: <0867dac0-bc48-4aa9-891f-2066a3eff989@kernel.org>
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
References: <20260527110147.17815-1-tao.wangtao@honor.com>
In-Reply-To: <20260527110147.17815-1-tao.wangtao@honor.com>

--------------YusAIRMqlR7LLXeBVYeRGebJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 5/27/26 8:01 PM, tao wrote:
> Design overview
> ---------------
>=20
> ANON_VMA_LAZY defers anon_vma allocation until it is actually needed
> (for example during fork). VMAs that never participate in sharing can
> avoid creating anon_vma structures entirely.
>=20
> Before an anon_vma exists, rmap operations rely directly on VMA
> information, so no anon_vma locking is required. An anon_vma is created=

> and linked only when sharing semantics are required.

It is unfortunate that the design overview doesn't cover correctness
aspect at all. VMAs are subject to change (even before being shared with
other processes), and rmap needs something that doesn't go away across
VMA merging, split, etc.

I'm not sure how the idea is supposed work correctly.

--=20
Cheers,
Harry / Hyeonggon


--------------YusAIRMqlR7LLXeBVYeRGebJ--

--------------ey4l15FF9oEWH3xFySCAaCAx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCah7/ywAKCRCGXBN6rc5S
1otsAP9nwP515uUxVeg/W2YVm5teA1//l+vahNQqqxIcs095VAD+Jy2ls4/NwtfN
KAQR7h3eWnaTbpGNQamLViiFJG7giQ8=
=rhvK
-----END PGP SIGNATURE-----

--------------ey4l15FF9oEWH3xFySCAaCAx--
