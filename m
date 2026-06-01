Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB283BF677;
	Mon,  1 Jun 2026 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324426; cv=none; b=amV3xb39oP/qza+3w5wPud6NalbWW3hJgPSN2c8YJUAd5VKaELY+HaTMmWfmvAgncVDLyRiUuFosR1wuy90o3Nj2ssNlTHHIj3YJyOjTICGQ7Keoye+yFhHaXMfHGDHasKYSXwfDYV05KfMls8uQvPs7sfXep82a2F/P3LbOVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324426; c=relaxed/simple;
	bh=QeMROakwZdZHkDLhIH47+7a3ZgsknMReeO5Hs1OdOnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IeAvtT1Gt7Jk0pQ59HirRxksvaqQylrMPyRAb2WHwCpom/QtkDbJPWnWCfQAn+g2nks1LVMIVysUhZKOWCBLvX+z4pMrNiLhh31OQ95m9T9k3Fv22eNFJOyn+h/j13dLxXspptGtfy0aDz7gzgf6j2xDJrJPXGrHy5IIE3/CPiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZujRnOmR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZujRnOmR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555841F00893;
	Mon,  1 Jun 2026 14:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780324425;
	bh=lK1x1QyGigmchJVOJRAeD6V0d0tG2rfMqkc90kIGR+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZujRnOmRcAA8G15SxxAqDKF9aM09EiyE2zOcf0QqPupx2ixZfI+TWgejqBDvrB6M1
	 EUx+auS+wEk+hU+aeWtCwcO2UJUJE+EqgUxCewtXY6FoF5uyWYyJBuVwhHwBoNM1zf
	 gQr9dh53CCdW/ywRuHLtIzPMnp2FhoI7F5sK7T0LZZe5EobUcdOBWNhqpTLVjHsU21
	 Y0+pNvkadUQSgM/AM8xEpELr268ZdkERdybtJH/cz2gaSC2lb7/19YXBVAH4h2VHN8
	 8W4B1MxAqSHGVf1gTW2YCeUOSaMKE7reTCaYFzQlYnIk2izvxokkOtjrCLfKXbr9tZ
	 o2vfTlwF1nEqQ==
From: SeongJae Park <sj@kernel.org>
To: Cheng Nie <niecheng1@uniontech.com>
Cc: SeongJae Park <sj@kernel.org>,
	sashiko-bot@kernel.org,
	damon@lists.linux.dev,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v3 2/2] selftests/damon/sysfs.py: validate memcg_path staging readback
Date: Mon,  1 Jun 2026 07:33:37 -0700
Message-ID: <20260601143338.111762-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <44CF9B1C840A17EB+20260601084635.234772-1-niecheng1@uniontech.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Cheng,

On Mon,  1 Jun 2026 16:46:35 +0800 Cheng Nie <niecheng1@uniontech.com> wrote:

> Hi SJ,
> 
> Thanks to Sashiko for the feedback on patch 2/2.  I will send a v4 soon
> that fixes the stop() cleanup issue in the memcg_path staging test.

Thank you.  From next time, however, unless the new version is for very trivial
things like mail setup, please give time for other reviewers to comment (say,
one day?) before sending a new version.


Thanks,
SJ

[...]
