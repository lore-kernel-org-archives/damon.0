Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1F134388F;
	Thu,  3 Sep 2026 10:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431808; cv=none; b=JcbzFGnlybzCKwBFZKpp8/bKR9qT0H6rkkAc5EzZyFbNw8tX3wN4xnwV4u9dexMhGEaTT+K4u/N/Sn6TNEn8mN0lCz8jfa9t1VuHZkiqJH9Ko74ikPlYQsxp28boozQALVkN5HBllpnwFF8ghExJ15EUQgFcMdkWYuT3quHtBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431808; c=relaxed/simple;
	bh=22ZUzMnXtdQYEitOopngvwk/ja6iLf/slwghthetBoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I682ysnse2E1rY7l9qIVTjEUiSGhEfElBqV1pjKbetbSRB/4S8fhIt7B2sT44ByN0FaZfqD40K3nca43JI78YnPK7Kx3Cmwh8vabXbI7AkFHi+sS/GCFoRf0SnY1NUBWxa45kaqehwcwYfN+9EDjMai75+eyMnyMFLCWgHY36dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwM9M3bi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwM9M3bi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838241F000E9;
	Thu,  3 Sep 2026 10:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788431804;
	bh=22ZUzMnXtdQYEitOopngvwk/ja6iLf/slwghthetBoc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OwM9M3bi2++tXyKq/GDB2qV08xvz6cdsaQwJdAuVcttmqXnn2TcZnhMTcoBUPWZWP
	 aUt0t6UQIeXnbxmuriuIBz55Q6Zu/VyR8fR1kHL0AA835goHcSDgdWS0QHmCqI9FIa
	 VO9W1UAL5Q14yccYG53TOFfZKiWnN8XAwrD+wESP2TGudJhjdnbfJYvJ8JCPU3j/UX
	 h5SpRGIfoSrktyIEp2GF8MBiFn/T/CkMts7ld0YbHZAD4TDIXyU7bbNCAaHNgu4+J4
	 8DvoFzpBDqajoq69zYumLZNiuagsHFYEg8ukmx+cBOyyKscZVX5o0FwJoqvRofI2iF
	 J0PzwyzQjmsGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/8] drm/i915: use hw_pte_t for PTE range callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: linux-perf-users@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260903103002.1091859-8-usama.anjum@arm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
 <20260903103002.1091859-8-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 10:36:44 +0000
Message-Id: <20260903103644.838241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> apply_to_page_range() now passes PTE table storage to its callback as
> hw_pte_t *. Update the i915 remap and selftest callbacks to match the new
> type.
>=20
> Continue to use ptep_get() for software PTE values and set_pte_at() for
> updates.
> The type remains an alias of pte_t on x86 until that architecture opts in.
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903103002.1091=
859-1-usama.anjum@arm.com?part=3D7

