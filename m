Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F221FF23
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667787; cv=none; b=b/5J/vFajoM1HZjGn5opTP1yOLrKjAzXRyCb2FXYl+236fZ5gcE3tTkfk5pGfgysCKnZgARMdZUtPfa/YEV3pGB9w1o2mbLFhNyV+kR++BtKthTJsd6q9sHk+Y3aapi/G6r8afvZJU6cexXj3o4qaPUD7VfEiegZE9PlzAj//HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667787; c=relaxed/simple;
	bh=cfVnVGUYjLNnZmMA1yfAbO8YfX+3Fdm8aoNFdenmsxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYkny8YogJxEQnVPk+UCqoxZIuDBP0OqjWyp0l+QKMqlSNTUfCV/akHMP4XGEbLH7d7qLarUcQBk3N1I/VjUMoFkMJCPZ0pXxxwGFdLJ5UD3djDQX7hZLewYqwhXivksoLGrUKahno0BxDkn93Ljc8Ub8a6pEURX8VnEHyBRt/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoO/qR8P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoO/qR8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D0E1F0089A;
	Tue, 29 Sep 2026 07:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790667785;
	bh=33XS3pljtgekiEg6Mr1oe8Qx6Mc8aJxJsqmFopwyONU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GoO/qR8P4mfouqOU/vYLtzRNnWFHNol3JvN9wjAKgcll/AWX6dLOtGmrz4tid2rEF
	 5EIwtIGqfhRxnymTsQnTNNgBbXaufIjKDDCQmnN/e88W2v5KjAfdhIaDNCARK9rK7O
	 1DxEOviVRHmIlP7J3q1uQ0wWR51kS1lrqbyPZx3PVZ5CEKbnAuun7+dfnlPZbeMDix
	 qahHEyK8vSn9BxrixT11N7nhXuSVwqFezJZGvSfDfjKHkTbz/f65d/HJaQIlOPLb0e
	 OZeUWYmUGJtS/X869qMQpFVayiBaW5/8UMbZVQ9QMrHa56fCAjNaPhT4EcXDlIH/iu
	 WbBbemCDLdU8g==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC] mm/damon/damo: saving damon sysfs configuration
Date: Tue, 29 Sep 2026 00:43:00 -0700
Message-ID: <20260929074300.40012-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928191332.138511-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Liew,

On Tue, 29 Sep 2026 03:13:06 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SJ and Community,
> 
> I've noticed that damo [1] doesn't seem to have a feature for saving
> DAMON SYSFS configuration.  I tried 'damo args damon', but it doesn't
> save the DAMOS schemes information.

If so, it is a bug.  Could you share more details including how the issue can
be reproduced?  Directly sending a PR should also be fine.

> 'damo report damon --json' provides
> more detailed information, but its output cannot be read by 'damo start
> --kdamonds'.

Maybe this is also an issue that we could fix.

> 
> I'd like to know if there is currently any way in damo to save the DAMON
> SYSFS configuration that can be correctly read by 'damo start
> --kdamonds'.  If not, would it be worth adding one?

I believe it would be useful.  Please feel free to send a PR.

Nonetheless, we added the json/yaml kdamonds config support mainly because
there was no good way to flexibly configure kdamonds with the command line
interface.  Now it is much more improved [1].

I'd recommend using the command line interface.  That is, you could copy your
command line setup in a bash script and modify/reuse it.

Is there a use case that it cannot work or suboptimum?

[1] https://github.com/damonitor/damo/issues/3#issuecomment-5655965736


Thanks,
SJ

[...]
