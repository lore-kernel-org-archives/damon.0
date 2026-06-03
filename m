Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191F26E71E;
	Wed,  3 Jun 2026 00:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780447870; cv=none; b=S+ViS4UEgYx594ZxpW1j99Z4KOBbtoyFOZbpyMMAev2kfsV5AFas1uXxHQFQcXo8rNF0mMS8eVzhXA/xSxdp1sw9q80sVQoVMKNSRHFqTzmjmLzYs+on2lWvF8gj1hjC+2He1ANVuecBrCQE4bGwNpLWl2ljT0kyzlvdWK4Fzts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780447870; c=relaxed/simple;
	bh=Cuu0zt1E2g4zBrWtkh6YZleB43ciQHvWHB3qcO3HWBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnK+1Uf8dn5LnqCNvCu9Nlywa8X9/wqwqaFXYUAQF+VWJl5ofI3jbM5W+y1QpmRid4sao3b1eM84CB+xb1L4yUihnie9yQdc+8wh+PYrQnsMAC2KIzDtzfRrnE2rle5K9JHfiFr4gdkLSY32jHN2ulxP5SrUqZYlE1s+XlIwrrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0CGVXk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0CGVXk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1BC1F00893;
	Wed,  3 Jun 2026 00:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780447868;
	bh=vpWej4lHI3Jzfw+An+vLn1ofBTEB35ebLfh2RvR4+T4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U0CGVXk71mgV4sgYlfGTQozo/k3BVaiPah6GH42duukBz9SaIScfVFebBJGqDlaxL
	 dReP5BgZtSZojHesOkuGTePCbuQUu0BB78ZAlV/5IoVKP1O/DSbHegF2j/Wy5tXmJe
	 9HM3l4vMv61cWhCYGI71diAHgL9tya1STOKNth1s4t+nElpXNFW+2s4EFsKf4Wku4Z
	 nltgyfk9V3VNGuS61boY9imhKc0FM8qqfQr/+o7e2rLWjDtYr4UgsF/0xVnMpx9iRN
	 Na4eapBXoDtNC+EDU5nkuC1sNxbLuOVEkrx6Z9Gr00D76jkcJ37Zh/7bVezzQcLt/t
	 KirOD6dBms8xw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Ruslan Valiyev <linuxoid@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/damon: test kdamond refresh_ms
Date: Tue,  2 Jun 2026 17:50:44 -0700
Message-ID: <20260603005045.90000-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260602100308.749f8ae894efc3bb73fa02e8@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2 Jun 2026 10:03:08 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue,  2 Jun 2026 07:28:03 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > Andrew might want us to wait until next rc1 release, though, as
> > apparently now we want to keep more time on stabilizing mm.git for the next
> > merge window.  Andrew, please let me know if so.
> 
> Yes, awaiting -rc1 would be preferred please.

Thank you for letting me know.  I will hold reposting of this until the -rc1.

Ruslan, please let us know if you think this series cannot wait.


Thanks,
SJ
