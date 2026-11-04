Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806620;
	b=pOKcDJ+4urlU8YGjghfzk8M/KmNe4s2LHpZDiBLnINkZqKwJQVsqIqQVA5M3gFv/j9hu
	 J7Lw7Q7HtF/W1KgVroHfLO+5j9jyWmXcqrn713WrrzTwS8iRzEH90MSfn3AlHXrQyQkZi
	 +2UCV8cA3EVdh7YzTEoay/hDg3fdsCQtbpQDScI6pGhwIevnyO5UvJvKoScRYhswgVv2w
	 6YNIHlMlKw8TQao9VXGN3ElbZRH9O5a4L+lOPJvxeOYHuBpAndlrb+OUavm3oyo7CJtOy
	 eQox/uOt7DCb0vUgZsKFJILD8v0uf5OvvT4KGyJPOyFlwOkPVHOkgAG8DqVuPeyE4JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806620;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=91rtiUe/bcG4k5Xjc7nZyZOJQYuQ+APASrUv58d3YCo=;
	b=O6u/3LNNIqRt/hnvwyQx1VciFfIGQakIzlbmE9noMG7Z7DOhxATNMwgB+AyyDQ9T6TLn
	 BlcygdyKgPxFg3LXYEKy9icDFvbTOzVIiUx6IQ4d0bEFypoWFhXJGDIvQS3zcB2MhbAZ8
	 QMM4PgqN+/RHB1tnUjG6rAdJQ5G5Of4OL6qcTa7RHXe1XVfv1HyQbLjvcJ+JeYBiY2FrN
	 IFwsXdKifUMNjoF+IelWBXlYDzm1sCnYJwgtMsEQ7MVdGJ3HDN2YPyEF/JRAaVnfTPqTu
	 VXzCNjAgIHZrd4rJvZK9gnNYomw1MIo3e78qEVvt/4e9BmTGbu5V+WeW8tnCCnyQrtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gUY10+qd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C043F606D804;
	Wed,  4 Nov 2026 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gUY10+qd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6289B1F00A15;
	Wed,  4 Nov 2026 15:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793806619;
	bh=91rtiUe/bcG4k5Xjc7nZyZOJQYuQ+APASrUv58d3YCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gUY10+qdYkwl/0fqE1gyFkd9MkTXLhSDeGkXS3rTMVGYtMcqkhwFqOhQkEP8+BiXL
	 7vnLQSQ9iaXsYwC+3khwbLtJi0psWgJkts2NFZsqy1+J6kL0K+CkuXwJMnQGw3YbeV
	 GW7h2LQQ/hcOVvMDBFep6u2HIqkk/OIUAjtfIXUuqf/LjKRGTqRYIAZCHkWttKOAgp
	 S6SyEAiw9+FmkXhw/mHZA1c6eaelOUKJilh/6c5f/fG54ndQzm00UxxsxyxFNRLVSd
	 5rslerFt/RQ2EUCSAm+mX42mfs9uisUrpbIzgwyMqgSGRUvDtKKviytekeht5FtCTB
	 Toz6SewxQ+v5w==
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
Subject: [RFC PATCH 3/4] Docs/mm/damon/design: update for age_ms damos core filter type
Date: Wed,  4 Nov 2026 07:36:42 -0800
Message-ID: <20261104153645.82945-4-sj@kernel.org>
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
