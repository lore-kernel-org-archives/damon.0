Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446801;
	b=0njf38QhAxzEWwJRnh85Pot31Ny9DwDPICNT0TH+2z3Nad3EjL3QdqsDakfmT9+yZbog
	 K+WGXgHjIhRvl5kzHmGesDngCCq+4yfQEwL52TvFpCDjgoFgsQmN4DnMiguS3u7aG18fD
	 2d0BfqzhA0mqlVOQus0bDmzi7zy/Xc5PzEdkPAf3kQ6U6lKtYicgsqCmxPsN9TTq9P7Mt
	 zYhTZKjMVMxn9z5Nk/vBm19uFTRas0q4TELxfb0G4sxbSafbE6Z36rH3eH93MWlzXNi2Y
	 MdG+/GaW6hNruenHQIfImoBpIF4DzehseYApJI8Q1WrrTL2xOkCzXlGU+FGXi2uEFKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446801;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BmSLZeMOrXtjJT391VTzHm5vcDp/H+TXxFKlLbmJKIo=;
	b=fTDAu2X/iiIEhpCB7Wo07bCp3BaimJ7QDb8NqSEEmuY3v/vgbBjnjlpmXfqtssodV4+R
	 BnKOtoaN7NhN6/VLrpzQ/MNZ5Osm8yF+aVCPN9KFTRUtyX8l5fH/s6m8gTmf8UP4zayRc
	 RchH8Dgxv4Fqi6dULOcpRA5PXo5rBCDTv9EV0QRqgJfV6vcWxC89o4bnAt4waL48Y+N2n
	 /BbOj6PoLzwEo0v9TE4ciVeyZrenrxJyVrx0739RBwmlKEKhJyQGD2w9gw87BmiBzS0ws
	 DieSqMgb5s9oDf9IN8VAFi8+98+J2GgiDxHRrddXVryQUrpeFj+RKmMuRjeJMNPfZKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S5g/dHzW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB6D606A321;
	Mon, 23 Nov 2026 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S5g/dHzW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6291F000D2;
	Mon, 23 Nov 2026 15:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446800;
	bh=BmSLZeMOrXtjJT391VTzHm5vcDp/H+TXxFKlLbmJKIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S5g/dHzWyh1+k+1NQKyrS8oVqmpxiqv4nPd3rsQNb3VKSffJ+Aslm0nl/W7EIx+Bs
	 Vt4l2xJV/+o+vgo9mY8hkqZfGWUltMtk6Hs7fFJ3NM0jXOJTx/7YBrRXtCIYsoh/dG
	 Vdg/l5L9hYUUO7iOYyQAYrUK4CBzTj6keOl5QxaVwp9DmSCATH4UTRidSR44JhABWK
	 jBfUIUZMaa1Qo31zNU5x72tBq99S7nFSoy04vr8rF4AJqeP7CPf0EW2+ItidKJm5mS
	 80PsmD8MBQNp6EwtTwBu4jDwyOavuK0hPXX1L8hu620r3jM29NfXrJ2MEl1jlXUCZO
	 CR29qYfON7HJw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mattathias Pinchover <mattathias.pinchover@uber.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 4/6] Docs/mm/damon/design: update for sz_ops_filter_passed_last
Date: Mon, 23 Nov 2026 07:13:05 -0800
Message-ID: <20261123151309.82675-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123151309.82675-1-sj@kernel.org>
References: <20261123151309.82675-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mattathias Pinchover <mattathias.pinchover@uber.com>

Update DAMON design document for the newly added DAMOS stat,
sz_ops_filter_passed_last.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 6284b90054430..ca8fbf93d556f 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -876,6 +876,8 @@ scheme's execution.
 - ``sz_tried``: Total size of regions that the scheme is tried to be applied.
 - ``sz_ops_filter_passed``: Total bytes that passed operations set
   layer-handled DAMOS filters.
+- ``sz_ops_filter_passed_last``: Bytes that passed operations set
+  layer-handled DAMOS filters in the last ``apply_interval``.
 - ``nr_applied``: Total number of regions that the scheme is applied.
 - ``sz_applied``: Total size of regions that the scheme is applied.
 - ``qt_exceeds``: Total number of times the quota of the scheme has exceeded.
-- 
2.47.3
