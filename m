Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806620;
	b=zXz0MIvObiie4pseUUfvZnjeBeqGoIjmrC4J4pyPaDSrWyT3NzAthQXGdV3wOcnJI13r
	 xEmupxaSdsnykKIEokx7H10ORZbIiWgWGeW59gUM5KuNdN5ZTSUMV7Go/Ge/w0ucMxPPp
	 NYOXxo0ALULrF+YVCYCJ7xbmgVmjT4fi2tkZk5Tya6/2sN4I2SFXioCDUY78iuZpdg/+r
	 uXNXjK0EMytQdEMx+DfCUGYvPxdpFxJ14qX1atCSo1IXJf9+jetVvEzot9wLvfQpdbkqd
	 K090oIG5yZ/abXtM+KrWhi/gO+jfQiCUDqoUclN9qzfPhnNOBAoR7QinGTWMzZS3Pnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806620;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wajzrzMNwWMprOwxfVXw4rbgafdH+J9WHgqDAMj2GDo=;
	b=GoariZgBAbXbscvNt2Y0CQ8lvbhttMv+tj7lQ89beG3AknCJjm2vHLNOQn1jzSXjRy61
	 U3UXdUIc+ldubdxPneTv9E9YOS79SIPapSkkPA5E+D1gqBWX6ik2vbRjFEYVm+KhVQVbB
	 OhU2ig/XDpwN/8hzWTA6PIxMZ9806X2SV1ry5Po/ZNmqcADmeaC6PPFiMX04tXFukuuC+
	 xE/ePQ3qW/7+PmXRNjlnfuRRqlP1k9rlFmx/8Rg8ur6Fc5viDe+sX7HrTBcaBSXMPm+1S
	 CL9ODFnbP4Ka95TFgN/peTNGj8iDcGPOcTJStE58SKA35aHO/bufNSFax22TKK74EjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUSTHPfX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FE5606D80E;
	Wed,  4 Nov 2026 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUSTHPfX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52C81F00A1A;
	Wed,  4 Nov 2026 15:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793806620;
	bh=wajzrzMNwWMprOwxfVXw4rbgafdH+J9WHgqDAMj2GDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fUSTHPfXVyy6eDhEmXV0pnycw1UJqdw0B8+lWylxFcXirpx6O0qCliB9/lW0fp5HW
	 lU+aSu/oYSGUW23wsJuGLsEi6HIdqkO8DI8GmcEVmlyMoZ8Rto3P/+FhZvEsIw61Xb
	 fxlZ9EPX+lm9RxCJOggxpzuGUnhrZz5XQrdf/2Di8zw5WZhrp1GfT3TNIvR9L3AnI3
	 VtWgWNe1lJpxsu1jbFZ48yijjiHQdJwPLDIF6349sO2bzQUgukoFotCiC5+s48wsAA
	 CwFJrWbFeULQ5V9HcAeYXs9YHOXElDKApgfofnzOBANckqnFE+nKdvLvtFXvM00k9B
	 9RSCczVberDDA==
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
Subject: [RFC PATCH 4/4] Docs/admin-guide/mm/damon/usage: update for age_ms damos core filter
Date: Wed,  4 Nov 2026 07:36:43 -0800
Message-ID: <20261104153645.82945-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104153645.82945-1-sj@kernel.org>
References: <20261104153645.82945-1-sj@kernel.org>
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

Update DAMON usage document for the newly added age_ms DAMOS core filter
type.  Add an explanation of how the age range for the filter can be
specified by the user.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index cc7465251bb6f..6093b1c8fbfd9 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -559,6 +559,9 @@ For ``probe_hits_wsum`` type, you can specify the minimum and maximum probe
 hits weighted sum value for the filter to ``min`` and ``max`` files,
 respectively.
 
+For ``age_ms`` type, you can specify the minimum and maximum age in
+milliseconds for the filter to ``min`` and ``max`` files, respectively.
+
 For ``memcg`` type, you can specify the memory cgroup of the interest by
 writing the path of the memory cgroup from the cgroups mount point to
 ``memcg_path`` file.  For ``addr`` type, you can specify the start and end
-- 
2.47.3
