Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774546;
	b=CVR8UbCLzisOI2rNQTmzuX1B/fm98UbQW4VRZ2YG8aYY9mgC4AbCsfgQv3Lc0zAcqLmz
	 SwSxN0ijP8Vqzte0LD+2l1d88XWk5s4JNEMa2/gp4/0knFKpZ975n163vAPtpoOnrwuag
	 AzNzXhuv24wfdq1ywll12MCkqVHemU2OV9aTMP/xKwVR/QROfhhnBUM1wsep+/SEC4dir
	 jxiw9xGfKsri9/7xY9RVISGa+bZx9di/pv8P8i0jZBOsqtpkY0iXshkTh4p047ZRldS7u
	 D6Ms7e6r+OkVa5zQg15YkOtoFiaU3Ior5Ecrv+Huhje5QnCzbRpJ197Xz8nx4L1nsLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774546;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wpJsxUs5k/v5Q/BJmFbBidw7iSSRFrTJt5QonQhU+Vk=;
	b=UvJcKaKOP7gtdfjWxg+LQTjNLeBe0gJvLhprl/l09Iyo6HogwUt+EZF5fNQ72X58dvPp
	 xlIHPNTjVGYC7bYjJh/az+/LrtElrWp87T84CGafZJW0m5RYfCW+6uUo72QAVvxx0qgHF
	 auXWW1RBWmNq/4uvkC74UEOxcgZ8G+neZOcL7XnzJMt6q5eYkQInFOYX8udZ11ffJBRUh
	 2Y3J1SidmjHUYBDhjAX2ke6VpNUJ8MkrVsvPOA3DNAXU+RB5U0Ii2FQwT/Tc2trPK2YY0
	 ZEyBfBDYt/DEh8ysxc2wwG/3YIBNlRhyBMXOM0AGmAsKCGpI0C3TTroGDboN0zhFb+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAg4GCbX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B9B60A3817;
	Sun, 15 Nov 2026 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAg4GCbX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141B21F0092B;
	Sun, 15 Nov 2026 20:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774546;
	bh=wpJsxUs5k/v5Q/BJmFbBidw7iSSRFrTJt5QonQhU+Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DAg4GCbXkR2wW9RLIVal7F0rVzKWUYpk5e8bIAkwv0wIk2bmYWXK5nQZQ3pLSjofO
	 QGurE227J1JXsGJ4jya6+feB+xYvDKqqFCkJyPhVhg0udHzSwWWGrtPQQxVhH+YHvH
	 3Rkc+g553eTVaPJmxSliRd11f7FniUllftDxI0zLrxyHuQvX9+rg4Te4hzYS7aoYQI
	 6R71KtxCQ/S+EZQ+LbMMXaMaUkjO767VawaUty1e70oC1EjD7fi8XGa8faCKK8X8Po
	 Jct8Fzo+DP9ThYBjTCfrEacIX43mJcvfnZJml7iQy+9DexClo2kUPfRHCcuys5elQ6
	 MSSdAAVT9thcw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 11/27] Docs/ABI/damon: update for report producer sysfs files
Date: Sun, 15 Nov 2026 12:28:29 -0800
Message-ID: <20261115202849.99134-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115202849.99134-1-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
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

Update DAMON ABI document for the newly added data attribute report
producer control sysfs files.

Signed-off-by: SJ Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 4acb2015c2f4f..c9f718f126c70 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -695,3 +695,23 @@ Date:		May 2026
 Contact:	SJ Park <sj@kernel.org>
 Description:	Reading this file returns the number of data-attribute
 		monitoring probe-hit positive samples of the region.
+
+What:		/sys/kernel/mm/damon/admin/reports/producers/nr_producers
+Date:		Nov 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for controlling each DAMON report producers
+		named '0' to 'N-1' under the 'producers/' directory.
+
+What:		/sys/kernel/mm/damon/admin/reports/producers/<P>/report_type
+Date:		Nov 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the type of
+		the reports the producer will generate and submit.
+
+What:		/sys/kernel/mm/damon/admin/reports/producers/<P>/producer_state
+Date:		Nov 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	A file for requesting actions including enablement and
+		disablement of the producer.  Refer to
+		Documentation/admin-guide/mm/damon/usage.rst for more details.
-- 
2.47.3
