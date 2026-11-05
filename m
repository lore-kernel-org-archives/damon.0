Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793853884;
	b=caWmymndVaWwZ2eD4ntJW84FYhhiwCNCgAmUz3agdeGy0z4b/H8EKMjZ7bNDTiYkOesL
	 vERqFnvoMJiK4mXFDjqMqmCzAR+qWNB9cQjf8fMdf6jf6W36eLwiNcenbk4/c2tTnbFtr
	 UzxJI2XRllIW5PAnWgoOabHGWO8ju6eAsF29ESKqn1wMfzFhIGbEm+irRT7xy9eF2ES0h
	 F8kqn86Daj/TcQHxqpIDrxLzK7HWybICpHLm7WeqYp+eehX2GKDhmpcccBJSgMVjXfLO1
	 YhnIbmdTadpxeSBSSl/SoJ5EjDf6Bcph07kn3+JpJCqpd4JjqwcT98cFvGVGVaPUOqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793853884;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wajzrzMNwWMprOwxfVXw4rbgafdH+J9WHgqDAMj2GDo=;
	b=yJKNvvLY+OLDdojiobt1xjwCENg9JW/vYQQDInrrbzM06QAh91HHms07sQuakhljfJ/r
	 IBD9Hnhmf21BBNj+d4zs0d2fjD6QIveDRbno4GESczOVZrYaAh8dZ/JRPe7j82aotlgt7
	 Gl5/AQTKqZghhgZClFS1p17VDA7Ty1RM1wriFpzQL5o4QTNGtNaA2dGM6znIiJt/0ytsK
	 UTcxnMG60g/+G8z3HGwIHf+NhEYYWziRRrabWu8fQ2GPulrc0SfNWZ5Vb2w00Gf5gnbfi
	 iFB0IU+wSA03884+DAxfIbUK3zXmSRekxMpMZvg3xhKHsUQxZq8qgDBqgYtTu7Iedqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RnfYCL6o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D51A606A33E;
	Thu,  5 Nov 2026 04:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RnfYCL6o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7CF1F000C1;
	Thu,  5 Nov 2026 04:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793853884;
	bh=wajzrzMNwWMprOwxfVXw4rbgafdH+J9WHgqDAMj2GDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RnfYCL6o3nODbMVVbIV2YvD2g5Q6XTsL8674X3ii7XWst5EKMH86iZiZFjHmtrxeZ
	 ctT+rAeUYUt29hkIeTgXvvgnjyPuQJnR+9fPfmmglK4Sb+GN5s8EZxw4ykuyeuc9Nd
	 fyKK1yy/4gNVY4KJi9jIhFEYTfWZTNQS7CQQvqDUGB5t4czCxl28PkB9KGNwYUBHp/
	 RTRlb4omF/yU2yp0brJppk0phkWudEUut3ygogf/8WgzgA/NeFkJBectl7ozJ6rFDL
	 eBIFzrYqvkOeatxozss3IGM5+BWBJCEmH0XzZDYdsBmMGhHlU9BF0ZmVuVdlIemjEq
	 BfxvWSdBwptqw==
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
Subject: [RFC PATCH v2 4/4] Docs/admin-guide/mm/damon/usage: update for age_ms damos core filter
Date: Wed,  4 Nov 2026 20:44:24 -0800
Message-ID: <20261105044425.87142-5-sj@kernel.org>
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
