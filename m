Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9577576EAA;
	Tue, 22 Sep 2026 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097698; cv=none; b=s+ulXs3y/hxygUmdis+WFZZ4zaXBY1dsGLF/C9HscQ5ttN7KGWlGgORZgmaX9U7EbuacwDRQ4PnF8FbJF/BqGM4FDu06Bqz1O6aBchXhs0iVsLENCOL/QrbCh9YjXq6Vedf05jjUQP4CZUE56S2VBjpSCelmeyEBSOA5n0jxHTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097698; c=relaxed/simple;
	bh=K0bVgIlLnB7+MHf9lKzOC3Q8w+xEfr0U8+ovWVRrZTY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dE1C45g7/XcBCVxrL5bJm74UYjKI6GJqCjCqYFJ1PHj7OLyChryWh4ibS0YzZGF8LCbFKQ8Z2b8gnP5S4oiMFlK/3HIx53YKo7lijkTb7d/btC3l7vQcNvj4+wqjTw3V/+wvVOM4yH13/0qf0Crn7gXBTbQnddOrLWUX7O7iPOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pg3nv905; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pg3nv905"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4775C1F000FF;
	Tue, 22 Sep 2026 17:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790097697;
	bh=K0bVgIlLnB7+MHf9lKzOC3Q8w+xEfr0U8+ovWVRrZTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pg3nv905QJaaVFh4M7hIX7VFLceYBmLZCuGqi9XSKcfdCdr9TG8ARsJiYHBXxC+OK
	 qkhO29caG/loQlxntbHm0hXT1ucbV5OeupvnskLvdPcr7IxZOpNsaBtCfhTVmOhF4d
	 0tRxAy+4iiQb0jzcC+7RAeLCUU8DTEBMYO0pJO0Kbt6ROHhNCdOdLhU5ANhjrVPbr4
	 +dE7DzuAgsxGIXcGX1ZaJw3dj5VpxOzxLplHoWX7LXAOkYUjGImQIPy6zEG77C9sD2
	 R6N7WEyCN41hv1U2G4bs6B2Wv7qpYskj4yHKlpG1tKVqUARAAwLJ5Z6reisjX3Pjjw
	 pL9pVLd1EeO6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/9] mm: rename pointers to software PTE values as
 ptentp
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, damon@lists.linux.dev, intel-gfx@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260922-pte0-v3-2-5670b8cb9059@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <20260922-pte0-v3-2-5670b8cb9059@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:21:36 +0000
Message-Id: <20260922172137.4775C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Some interfaces use pte_t * for a software PTE value rather than for an
> entry stored in a PTE table. These pointers must remain pte_t * when
> pointers to PTE table storage are converted to hw_pte_t *.
>=20
> Rename these parameters in the install_pte callback,
> write_protect_page(), and guard_install_set_pte() to ptentp. The later
> Coccinelle conversion skips pointers named ptentp, allowing it to convert
> the remaining PTE table pointers without changing these interfaces.
>=20
> Some functions already use ptentp for such pointers, including:
> - madvise_folio_pte_batch()
> - folio_pte_batch_flags()
> No need to rename them.
>=20
> This patch only renames parameters and makes no functional change.
>=20
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-pte0-v3-0-=
5670b8cb9059@arm.com?part=3D2

