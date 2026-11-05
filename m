Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793853889;
	b=EUBQayynu2f40EPgtfdLhA07NW3v+cpJG/aXV7pOVZ8qkWXuRRrfd+9k3111gf2kPVP2
	 qr/SzAAHZfGbcWdBOaLYLsl7qDALojpuMN3MlW25GSL87Xr+LzzmDtH5HO0/EIjpmhWAl
	 74XVQZBYOV5tL0cmKAEpuwUHYBvMxQC8olJqj2vKPLX5b6vXOWS5vt4raNd1fdKz6Pdp5
	 Ah8oUa0K1AUs+fDDTkI2MKmyhyXbgtDBdz6ZfsnOHmA/fyWqg4XdSYLosfstD2OGzK8sl
	 MZt68JaX9f/QJJn/1rBx1t4LmqJ69x33vWm2pcXE4O7WJlpmhR3j+LOLB6ka1h5QH2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793853889;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=91rtiUe/bcG4k5Xjc7nZyZOJQYuQ+APASrUv58d3YCo=;
	b=1UHQch7gbMPH6cNmfelBOYxvgua02h7Pb2gQZ7oNGam77qhbflRdZKm8VriBtrIo75SM
	 xwa6SrHyOn4GLNky4DTewqSpJ7azXzBWyg8uQqjqjlTUGapNf8hdVerQgFfL0c1XGUiaF
	 qDOFwFWl/GsJgyOCqbgxm1YQgp67YFHQbSV8GSo4O5SW3DjIsUQLcw8dD+Cbop0gQdaGV
	 OO9wEEWijUVSliwlKuCyG2gLuF9qvS7VBehumrWWUeUiF5zthTnmy2+V1tX+yC5StEdaV
	 DUwvFiRZLUBDKRgkLtLW/lrYBZ+WHj8MkufyIJHWpLb9lvoR/mV+EaLTOxhkX5lmdxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fNDQeP7f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C0A606A337;
	Thu,  5 Nov 2026 04:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fNDQeP7f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EC81F00A15;
	Thu,  5 Nov 2026 04:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793853884;
	bh=91rtiUe/bcG4k5Xjc7nZyZOJQYuQ+APASrUv58d3YCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fNDQeP7fFkkIn1uN0pJ1N0tE3fxgJcOYDJzvCmWM4EnaCSgAyUlOi/Eld719LQ1iy
	 25SqhIwrtOqdGcPpejzqSnuY1aeMsTvQ60lRBsxbZhRs5y0YHo3Uo2JY8xR3vWHkoD
	 yb6bEoBWYPkJPrNU/AOae/bbK0SAOhllxeDzsmIMulIDpUWWPU1+2fpI9qLhpktAxw
	 B9by1ghtewDcjxEX/BtNQD5s0zr9Lz7hvOBQ4nfMHIpqqG9bU/zbpwm4RHOo6nON80
	 +oy9AtCrol82Wlx6KVKm52hRLE6h//bBaAuZRHcJlqGlinqtR73KqWHp8tEfFqFftM
	 Rs5qxbAeQZ9jQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 3/4] Docs/mm/damon/design: update for age_ms damos core filter type
Date: Wed,  4 Nov 2026 20:44:23 -0800
Message-ID: <20261105044425.87142-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105044425.87142-1-sj@kernel.org>
References: <20261105044425.87142-1-sj@kernel.org>
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

Update DAMON design document for the newly added age_ms DAMOS core
filter type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 0689fd48446dc..8440c4954090e 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -838,6 +838,9 @@ Below ``type`` of filters are currently supported.
     - probe_hits_wsum
         - Matches to monitoring regions having a given range of :ref:`probe
           hits weighted sum <damon_design_attrs_only_monitoring>` value.
+    - age_ms
+        - Matces to monitoring regions having a given range of :ref:`age
+          <damon_design_age_tracking>` value in milliseconds.
 - Operations layer handled, supported by only ``paddr`` operations set.
     - anon
         - Applied to pages that contain data that are not stored in files.
-- 
2.47.3
