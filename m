Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1401E2673AA;
	Thu, 27 Aug 2026 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838596; cv=none; b=GnCIJRiktlyal5uwpoUZIqqmHzN4WOxfiy65FK/pET7KlBhRDC/OSztY9AyAO6xGSgCxnGgyz2c5p00Ezz8xwQ89w/4cAmlFu1wIqu4nJnzkTpWaiZh2acxj+YZQoAek/FroLHBMkXMdwSe8QaP3avZ8m1CzELu2t9fKgsRZBgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838596; c=relaxed/simple;
	bh=74ca8qAHYrBCUETjtbQAmUe36tLPTi7Y6UvRtm6iPpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLBhTik70VI0qgndXYRG7GzQd5USIved7Do+C5F70EN9mn+bR5Zk//YC1eeo82e8ETXVwfVPR5Wv1u+xGHI6r7Mfxoc7TKOrRhncMtZXal9Sb8dd2lD5+PyjqgnOlau23hWRJ3xL46SuoIEE0ZDO/9LXaiRXKSN/hAoUW6iAGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKhpbEsp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKhpbEsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793E01F000E9;
	Thu, 27 Aug 2026 13:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787838594;
	bh=MdLgXdf5TcxCSOGCt8+O5lejStWVA0dR5b/HwK08zHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VKhpbEspM7u4jb8cPd7raVUz1QkbPa4PUzEYBzB/uxI7w3xR7Pe1jCdx8yRhOJjQI
	 kVop7F7Tfm2oauPuSzBpAIffzQRORk2YWxMNdAJSfo0dAGbsqGOlvbSFHTkPtsVoO4
	 ROBRzwGfRElypIblqq1zO9J4cQkESnvwVKZ66AjTqYeo9jnJBTOFZ5w8yqdesXqiSW
	 evMVeXNIWmysf5Wof2yCbG8lVAKDp/Bb3hlf25BL97N8dgBYwBmrzGFbsqTWERzW9B
	 2YAVz/vhWYKm0cj8/42I7O/O1D4nwRU5qSSa6KhvGBtUkLHoX/mWre6EblnT/c+Lk3
	 Gl/4pVc0q593A==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: fix damos quota walk-position tracking
Date: Thu, 27 Aug 2026 06:49:46 -0700
Message-ID: <20260827134947.123814-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827060255.18114-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 27 Aug 2026 14:02:55 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SJ,
> 
> Apologies for the noise.  I accidentally started a new thread due to
> missing --in-reply-to flag in my git send-email command.
> 
> Original thread: 20260827004438.82746-1-sj@kernel.org

No worry.  Could you please re-post the reply to the original thread?


Thanks,
SJ

[...]
