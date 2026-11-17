Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924981;
	b=Q4chtcV+ITSeodZ9BP4Rn4973kZeuyNMDrpWEcGvT0sUdYzrY3/+znhB/ohhOuTeukEK
	 OnIjz0mddfE0xxv7t4QJKMypXXUuNiJW2KA3HRsmf1+9HZVyuTT2bbx3bRLrpU4ZsWZ6g
	 twupyCzgtkE2rAxGfPMyusjkhyKmR9joZlYWHSWNf7BMbSKK61WaZyhLi34X67AB8YvCX
	 3KiBzwoesKVBORJPPTgZyzDovP1nTM7SBem0zu8fWPxuapTeitwEklWWpN5VltRqNW31F
	 I5BeSUUY5NRjto0akAjjiniWvNyjLEoMo3930GBHdlF3ZxPU8kCrv4/AdQUXrfuv1ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924981;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cM69XD6jCQAyvU5JbNH+E2DCO/IIg1MBUqnf3B97zP4=;
	b=XLGunEDz0JJgW1lnPYPS2PzOGENOjuOU/L9syio4qHnK40JAHyRMPWid15UHf7iuaHGc
	 UIM8FfTRd5sftUepWBBL3OtoJR8wG3NEOfO2xCrHGfmwIT90rdjc7IxVsAfhTSboRnLQ+
	 lLeYUaLPuVxYpzhvV2tQzZQnNSZCO1v6EhGo0crsu/u5EmLDiX2kGa6vct4tOHnwQXRfu
	 l4w7yhp3MkkSeAh4NQSrxchEWEjjstRbIoFoeIqHLNuzhGgbmc2RtkImxti38gL7wIrvr
	 eF6VlDLukDoyMf69wIu86jA29egsvnb41v0bzAUWu9AHE5pAmrCwv/fPkjslxDHVutQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OCaH7VEe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC9E606A334;
	Tue, 17 Nov 2026 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OCaH7VEe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F4F1F000C8;
	Tue, 17 Nov 2026 14:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924981;
	bh=cM69XD6jCQAyvU5JbNH+E2DCO/IIg1MBUqnf3B97zP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OCaH7VEeTQRdiRW56c7+s5byHdlpeJIDJ73r90cB5ISn2fCL0UXy/EZR2jw79lmay
	 PwYZLyV8DM6vGH7lgoJn3lGb4cLqAOhoYf0cNZ1GuD3e9i9fcWZa8fIYrR6y6eOi6n
	 vqh2QRDfhgTCRWYsUUJAgSWRtzmjiS6+mXo6uKNGJr2RNf6Gpt4HXnTPU9OBU37OzV
	 uBIdjNdZqhZzF2je1wv3lJoZhlfyOJH9OYvPblEyY3ZGLEHgzT6kea2sMukYqlhgHY
	 EQoYn4Kcl8zGr0I1DjSVXHQ+2IudrewbpuxH6ivzH0ylH7DLGncqoYbtAxkE6KoKdp
	 8HV9RkmjiW7mg==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	mattathias.pinchover@uber.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 3/6] mm/damon/tests/core-kunit: test sz_ops_filter_passed_last
Date: Tue, 17 Nov 2026 06:16:12 -0800
Message-ID: <20261117141613.121192-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179488734513.2.6285120857568566018.b4-reply@b4>
References: 
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

On Tue, 17 Nov 2026 14:49:05 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi Mattathias,
> 
> On Mon, 16 Nov 2026 19:10:06 +0000 Mattathias Pinchover via B4 Relay wrote:
> 
> > Add a kunit test for the sz_ops_filter_passed_last DAMOS stat.
> 
> Since the motivation mentions contexts with multiple targets, maybe we
> could also cover two targets in the same context, with the stub returning
> different sizes for each? Checking their sum, then changing the sizes for
> the next interval, would verify both aggregation across targets and that
> the value only includes the latest interval.

I concern if that will make this test too complicated.  Testing those would be
good, but not necessarily for sz_ops_filter_passed_last, in my opinion.  Those
may deserve a separate test, if there is no test covering that.


Thanks,
SJ

[...]
