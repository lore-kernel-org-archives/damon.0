Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F9D19CD1B
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781977638; cv=none; b=rv2fCnWf3/b1h4Avz1Y8q4+gvofbDlP5si49Rr6IztqELHcy5sAn4fbKdosWkOsBX+2FDMdb96aCzkugOwI47yXuNnD3+w5s9fzMDaJrBDwGffoTP92sIfLaDNfNtnUgSUkd2TUM/lOCGBB/v2rYWOwRWhMmv++d9I74zGzPJN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781977638; c=relaxed/simple;
	bh=rWu/ZVvkpmDgNyvgIYwxthYlqP+7BAWUjy/DMjeLTks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUahU2Qfox68gKKVccIIq7S9xzkFLOrgIe5fj+WuNyyAoZCjm5dV72wf+qhU7xxT/4zMb5nT/6OJMjE5NS8bX6smNNdTwdi2vtXgE2+9ppuJUeb+sYDMS4hG0POkHCqHmFxqcs9qSRhLOWDLxn9QnZErRsHSljs3X9MnHGX1Kuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dasbW1hN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dasbW1hN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922071F000E9;
	Sat, 20 Jun 2026 17:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781977637;
	bh=rWu/ZVvkpmDgNyvgIYwxthYlqP+7BAWUjy/DMjeLTks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dasbW1hN9cDLPmQfkgYTwHjZQbBZhIV90sEMSCRrUJWHPGOpmKW/4+as+qZ+Wcvxi
	 hiaokX57UDrJwrLoKgdFrjn2jCRnMTbtAOUDG7o+tnKwy0wljdByg9hLhWvrV5WrCx
	 UP9zPmtvex36zUS7wxwpiVFI8RYF3C/OWQhOTnSRZA4Kr+2ZCYh57tC4gqQblX9Vl5
	 bk4Nmg8QpPlUMBuuQCg/m81/kQhHClDBQ1Hnygp5q3ek/mGO4nHF5OFgZEn7xRaJrz
	 0+7B7O5GUF8CNsGfroNUeVEzxES+fsmMD+qh4Gjfxc73IvX3Z9H5GsyseBSDG5OHRk
	 ssJmo+QtugZlw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 12/13] mm/damon/core: remove damon_moving_sum() and its unit test
Date: Sat, 20 Jun 2026 10:47:08 -0700
Message-ID: <20260620174709.92874-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260620173547.0F18E1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 20 Jun 2026 17:35:46 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The `attrs` parameter in `damon_update_region_access_rate()` is completely unused and should be removed.

As I replied to the same report, I will do the cleanup out of this series.


Thanks,
SJ

[...]
