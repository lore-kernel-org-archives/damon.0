Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CAD53B0
	for <damon@lists.linux.dev>; Tue, 16 Aug 2022 16:54:00 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id m2so9747467pls.4
        for <damon@lists.linux.dev>; Tue, 16 Aug 2022 09:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc;
        bh=Xk8QZ6PI5FIXSI88cF6B51X+JsCPm0U1pnuH+eN4qwk=;
        b=GZkMF5537WOqGZ6dSz1yk3Fwh9WOXQd2aiaXzDRx2ywDpCPtE1ejy5FTvsC8OZKmYn
         SDmVhtG9FIcogpOhgqCePfeaipijymwB+aYF5WmZxBpQ5OoEs+wJTLAK3ckr2CVgNWRr
         ZTL+w/ApTj+5jqouCoJeVCUlYmdGIiQsrchutKDHDTrjYaElsZHxFeX1Z/YHxjIkeHCS
         qzX3p+6NfeN400D1noRwAYZlLyW6OzKMl8wn+JyEZkAJtuhN7w+PjDSaxgnIjK8QI1a3
         pIGYnRCw69hX7BKAcdWERSowRomeNs6yJwBDlFVHB2PRrIVn34XV68Tocs3AiqKHchhE
         xxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=Xk8QZ6PI5FIXSI88cF6B51X+JsCPm0U1pnuH+eN4qwk=;
        b=Xt2aicYhytPcDKTx+FIvmUwkXLTw/lz+qAjxY0mawehtoCuE4jEOHKDhQWpTxcWGe0
         dILwnmPTm1Mg84jvu/8AeNL/2UBCmb27gYMWypD9450jSNCgb58b5tBeHodKhNf59GL/
         Ra4L2RtdKAx2JPyBZCOPePP4ZMZi5vuCYROCs5SOvD6eU+iiopk0G/AY+xXQV1qrMTLI
         z8L53zfsVVessqJBNcJncQI0s7iJ2dNqSJi7JEfHz9qF3V+q0hp9B0HdhAgRAWyvVMLy
         avvqP4s6E6u2HZfskIkafDxv4chf2JCJElQZrzC41Qbc2sX5bHpr8mHdGmVIXcvGTnqi
         s8Pg==
X-Gm-Message-State: ACgBeo1VVnEMingb1ZfzXNazxnJFLqicoVy1Niz/dxC5UlnZl2TnGJ6+
	h3s6G3u8BuYFLWGc67FR+i4tKI8vTnU=
X-Google-Smtp-Source: AA6agR6HHuztH+cloMPNBNCf7Hvk8LSUZLqnC1cKQVqvjrH8IBrdyiOHGk+Ic4VZsuvhQR96pTLe+w==
X-Received: by 2002:a17:902:f712:b0:171:29d0:6f9f with SMTP id h18-20020a170902f71200b0017129d06f9fmr23275128plo.84.1660668839799;
        Tue, 16 Aug 2022 09:53:59 -0700 (PDT)
Received: from biggie ([103.230.148.189])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090332c100b0016c29dcf1f7sm9400988plr.122.2022.08.16.09.53.58
        for <damon@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 09:53:59 -0700 (PDT)
Date: Tue, 16 Aug 2022 22:23:55 +0530
From: Gautam Menghani <gautammenghani201@gmail.com>
To: damon@lists.linux.dev
Subject: Question about hugetlbfs tests
Message-ID: <YvvLo7wDBA6qL0L9@biggie>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have been looking to understand the TODO mentioned in the damon-tests repo
on github here: https://github.com/awslabs/damon-tests/tree/master/corr

The TODO in corr/TODO says "Test hugetlbfs". I want to understand what is required in this.
Do we need a test that writes data to hugepages and reads it back to check if read/write is successful?
Or do we need a hugepage scheme that is applied on masim, which we then check to ensure hugepages were used?
Or is something else required?
Please advise on this.

Thanks,
Gautam
