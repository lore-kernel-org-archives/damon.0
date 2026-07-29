Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DAC271A94;
	Wed, 29 Jul 2026 00:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785286252; cv=none; b=ba2ZynNvguFhDj4I2BjcIDzboz54vHmJ6REcYhwqvpnGnbjfbaRxkgpzNLExEhG5E21ix3DFeyioXbR+hPH1UbaggjFb5JK7g2XlvBPihDcaDlYZ5EbaesGPed/8Hyllie7X0wrxV0/OQmOymqYBNuprOeLdW93WWVSm8O2IPPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785286252; c=relaxed/simple;
	bh=B45dKl7LxKvBNpQcdS6XYLDVAKIOh7Ff5PTPchXAVF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Na0h4+Z6bPn6Wry5uBG1emv4BTQNV8BaHZ9jmjiBI04jWTGVrHrnrYp4XEcmCWE28HQn+Rdtte11IMbl2S8ysCqlV7lxWthm8ruXHJpoSBZk48KaN97ADX1cyAjuylufpgIRSzotrQ1Zxx3VJY9kuxpBpHMXqh+u9QSpQTHVgJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr9h2++r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr9h2++r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671541F000E9;
	Wed, 29 Jul 2026 00:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785286251;
	bh=ic9L3BJoSROKa6Eya4cGtNIhuOcX34TSYVnxCMS4B9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xr9h2++raMozjYdGXpFqN2gCSk96HdB3ot+KlijzrEGE42ZRLqDPiC+Pz1uTR8aka
	 +DTFtoD1Hj0Oo3slfFTxuJzgkIb7voJ/yvJ88Bku6Yy9jMxdoSSIt1cmwKUAkTZ9IT
	 z9niXhL88bcEoTgvlXWvrrm5ww7iGF+VauPtECwfKTcjdGn6dBwbIZvpBhjXTFKf23
	 1QCY77D4xbkGX305jAD//bJuZ+957FEQMXXHnCHfdJkhQPCNVAl5G8p4iJWGv0TQou
	 GsBmGGPCIi8tQhlDHb9Vv0QN5hqJS/xL6xodafApcD5J95vcYXjtLwWNYcftKh4KVM
	 2lGi2pj8YVrvw==
From: SJ Park <sj@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: SJ Park <sj@kernel.org>,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	jannh@google.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com
Subject: Re: [PATCH 1/4] mm/damon: defensively skip zone device folios in damon_get_folio()
Date: Tue, 28 Jul 2026 17:50:36 -0700
Message-ID: <20260729005036.98063-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728194714.3713735-2-gourry@gourry.net>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Gregory,


On Tue, 28 Jul 2026 15:47:11 -0400 Gregory Price <gourry@gourry.net> wrote:

> All DAMON physical- and virtual-address operations obtain their folios
> through damon_get_folio(). That helper already excludes ZONE_DEVICE
> memory implicitly via pfn_to_online_page() and folio_test_lru(), but
> this is inconsistent with other callers in mm/ which test explicitly.
> 
> Add an explicit folio_is_zone_device() rejection in damon_get_folio()
> so the guarantee lives in one place and covers every caller uniformly,
> consistent with other mm walkers that reject zone device folios.

Thank you for checking this and sharing this nice patch!

However, I'm not very sure adding a call that not really required for only
making it looks consistent with others is the right choice.  I'm especially
concerned if this will confuse future readers including myself.

If this is a hardening purpose, we have CONFIG_DAMON_DEBUG_SANITY for the
purpose.  What about using it with a good comment explaining why we doing that?


Thanks,
SJ

[...]
